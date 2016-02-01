module ErrorTelemetryComponent
  class Publish
    include EventStore::Messaging::StreamName
    include Messages::Events

    dependency :telemetry, ::Telemetry
    dependency :logger, ::Telemetry::Logger
    dependency :clock, Clock::UTC
    dependency :raygun_post, RaygunClient::HTTP::Post
    dependency :writer, EventStore::Messaging::Writer

    category :error

    def self.build
      new.tap do |instance|
        ::Telemetry.configure instance
        ::Telemetry::Logger.configure instance
        Clock::UTC.configure instance
        RaygunClient::HTTP::Post.configure instance, :raygun_post
        EventStore::Messaging::Writer.configure instance
      end
    end

    def self.configure(receiver)
      instance = build
      receiver.publish = instance
    end

    def self.call(recorded_event)
      instance = build
      instance.(recorded_event)
    end

    def call(recorded_event)
      logger.trace "Handling recorded error (#{LogText::RecordedEvent.(recorded_event)})"

      unless recorded_event.lapsed?(clock.now)
        event, event_stream_name = send_error_to_raygun(recorded_event)
      else
        event, event_stream_name = record_lapsed_event(recorded_event)
      end

      logger.info event.class::LogText::Completion.(event)

      return event, event_stream_name
    end

    def send_error_to_raygun(recorded_event)
      logger.trace "Sending error to Raygun (#{LogText::RecordedEvent.(recorded_event)})"
      raygun_data = ConvertErrorData.(recorded_event)

      response = raygun_post.(raygun_data)
      telemetry.record :published, Telemetry::EventData.new(response)

      event, event_stream_name = record_published_event(recorded_event)

      logger.debug "Sent error to Raygun (#{LogText::RaygunData.(raygun_data)})"

      return event, event_stream_name
    end

    def record_published_event(recorded_event)
      logger.trace "Recording published event (#{LogText::RecordedEvent.(recorded_event)})"

      event = Published.proceed(recorded_event, copy: [
        :error_id
      ])

      event.time = clock.iso8601

      event_stream_name = stream_name(event.error_id)

      writer.write event, event_stream_name
      telemetry.record :wrote_event, Telemetry::EventData.new(event, event_stream_name)

      logger.debug "Recorded published event (Error ID: #{event.error_id}, Published Time: #{event.time})"

      return event, event_stream_name
    end

    def record_lapsed_event(recorded_event)
      logger.trace "Recording lapsed event (#{LogText::RecordedEvent.(recorded_event)})"

      event = Lapsed.proceed(recorded_event, copy: [
        :error_id
      ])

      event.time = clock.iso8601

      event_stream_name = stream_name(event.error_id)

      writer.write event, event_stream_name
      telemetry.record :wrote_event, Telemetry::EventData.new(event, event_stream_name)

      logger.debug "Recorded lapsed event (Error ID: #{event.error_id}, Lapsed Time: #{event.time})"

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

      RaygunResponseData = Struct.new :response
      EventData = Struct.new :event, :stream_name

      def self.sink
        Sink.new
      end
    end

    module LogText
      module RaygunData
        def self.call(raygun_data)
          "Error ID: #{raygun_data.custom_data[:error_id]}, Error Message: #{raygun_data.error.message}, Occurred: #{raygun_data.occurred_time}, Hostname: #{raygun_data.machine_name})"
        end
      end

      module RecordedEvent
        def self.call(recorded_event)
          "Error ID: #{recorded_event.error_id}, Error Message: #{recorded_event.error[:message]}, Time: #{recorded_event.time}, Hostname: #{recorded_event.hostname})"
        end
      end
    end
  end
end
