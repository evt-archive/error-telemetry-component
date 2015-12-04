# command = Publish.proceed(event, copy: [
#   :error_id,
#   :error,
#   :hostname,
#   :time
# ])

# stream_name = command_stream_name(command.error_id)
# writer.write command, stream_name

module TelemetryService
  module Error
    class Publish
      include EventStore::Messaging::StreamName
      include Messages::Events

      dependency :logger, Telemetry::Logger
      dependency :clock, Clock::UTC
      dependency :raygun_post, RaygunClient::HTTP::Post
      dependency :writer, EventStore::Messaging::Writer

      initializer :data

      category 'error'

      def self.build(recorded_event)
        data = ConvertErrorData.(recorded_event)

        new(data).tap do |instance|
          Telemetry::Logger.configure instance
          Clock::UTC.configure instance
          RaygunClient::HTTP::Post.configure instance
          EventStore::Messaging::Writer.configure instance
        end
      end

      def self.call(recorded_event)
        instance = build(error)
        instance.()
      end

      def call
        response = raygun_post.(data)
      end
    end
  end
end
