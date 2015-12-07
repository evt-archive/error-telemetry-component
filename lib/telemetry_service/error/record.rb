module TelemetryService
  module Error
    class Record
      include EventStore::Messaging::StreamName
      include Messages::Events

      dependency :logger, Telemetry::Logger
      dependency :clock, Clock::UTC
      dependency :identifier, Identifier::UUID::Random
      dependency :host_info, HostInfo
      dependency :writer, EventStore::Messaging::Writer

      initializer :error_data

      category 'error'

      def self.build(error)
        error_data = import_error(error)

        new(error_data).tap do |instance|
          Telemetry::Logger.configure instance
          Clock::UTC.configure instance
          Identifier::UUID::Random.configure instance
          HostInfo.configure instance
          EventStore::Messaging::Writer.configure instance
        end
      end

      def self.call(error)
        instance = build(error)
        instance.()
      end

      def call
        event = Recorded.new
        event.error_id = identifier.get
        event.hostname = host_info.hostname
        event.time = clock.now

        event.error = ::Serialize::Write.raw_data(error_data, :json)

        event_stream_name = stream_name(event.error_id)

        writer.write event, event_stream_name

        return event, event_stream_name
      end

      def self.import_error(error)
        ErrorData::Import.(error)
      end
    end
  end
end
