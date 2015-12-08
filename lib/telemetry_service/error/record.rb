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
        logger.trace "Recoding error"

        event = Recorded.new
        event.error_id = identifier.get
        event.hostname = host_info.hostname
        event.time = clock.now

        event.error = ::Serialize::Write.raw_data(error_data, :json)

        event_stream_name = stream_name(event.error_id)

        writer.write event, event_stream_name

        logger.debug "Recoded error (#{LogText::RecordEvent.(event)})"

        return event, event_stream_name
      end

      def self.import_error(error)
        ErrorData::Import.(error)
      end

      module LogText
        module RecordEvent
          def self.call(record_event)
            "Error ID: #{record_event.error_id}, Error Message: #{record_event.error[:message]}, Time: #{record_event.time}, Hostname: #{record_event.hostname})"
          end
        end
      end
    end
  end
end
