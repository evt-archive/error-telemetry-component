module ErrorTelemetryComponent
  module Error
    class Publish
      include EventStore::Messaging::StreamName
      include Messages::Events

      dependency :telemetry, ::Telemetry
      dependency :logger, ::Telemetry::Logger
      dependency :clock, Clock::UTC
      dependency :raygun_post, RaygunClient::HTTP::Post
      dependency :writer, EventStore::Messaging::Writer

      initializer :recorded_event

      category :error

      def self.build(recorded_event)
        new(recorded_event).tap do |instance|
          ::Telemetry.configure instance
          ::Telemetry::Logger.configure instance
          Clock::UTC.configure instance
          RaygunClient::HTTP::Post.configure instance, :raygun_post
          EventStore::Messaging::Writer.configure instance
        end
      end

      def self.call(recorded_event)
        instance = build(recorded_event)
        instance.()
      end

      def call
        logger.trace "Publishing error"

        data = ConvertErrorData.(recorded_event)

        response = raygun_post.(data)
        telemetry.record :published, response

        event, event_stream_name = record_published_event(recorded_event)

        logger.debug "Published error (#{LogText::RaygunData.(data)})"

        return event, event_stream_name
      end

      def record_published_event(recorded_event)
        logger.trace "Recording published event (Error ID: #{recorded_event.error_id})"

        event = Published.proceed(recorded_event, copy: [
          :error_id
        ])

        event.time = clock.now

        event_stream_name = stream_name(event.error_id)

        writer.write event, event_stream_name
        telemetry.record :wrote_event, Telemetry::EventData.new(event, event_stream_name)

        logger.debug "Recorded published event (Error ID: #{recorded_event.error_id})"

        return event, event_stream_name
      end

      def self.register_telemetry_sink(publish)
        sink = Telemetry.sink
        publish.telemetry.register sink
        sink
      end

      module Telemetry
        class Sink
          include ::Telemetry::Sink

          record :published
          record :wrote_event
        end

        EventData = Struct.new :event, :stream_name

        def self.sink
          Sink.new
        end
      end

      module LogText
        module RaygunData
          def self.call(data)
            "Error ID: #{data.custom_data[:error_id]}, Error Message: #{data.error.message}, Occurred: #{data.occurred_time}, Hostname: #{data.machine_name})"
          end
        end
      end
    end
  end
end
