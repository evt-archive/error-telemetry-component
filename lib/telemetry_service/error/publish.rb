module TelemetryService
  module Error
    class Publish
      include EventStore::Messaging::StreamName
      include Messages::Events

      dependency :logger, Telemetry::Logger
      dependency :clock, Clock::UTC
      dependency :raygun_post, RaygunClient::HTTP::Post
      dependency :writer, EventStore::Messaging::Writer

      initializer :recorded_event

      category 'error'

      def self.build(recorded_event)
        new(recorded_event).tap do |instance|
          Telemetry::Logger.configure instance
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
        data = ConvertErrorData.(recorded_event)

        response = raygun_post.(data)

        event = Published.proceed(recorded_event, copy: [
          :error_id
        ])

        event.time = clock.now

        event_stream_name = stream_name(event.error_id)

        writer.write event, event_stream_name

        return event, event_stream_name
      end
    end
  end
end
