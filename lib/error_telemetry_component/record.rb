module ErrorTelemetryComponent
  class Record
    include EventStore::Messaging::StreamName

    dependency :logger, Telemetry::Logger
    dependency :clock, Clock::UTC
    dependency :identifier, Identifier::UUID::Random
    dependency :host_info, HostInfo
    dependency :writer, EventStore::Messaging::Writer

    initializer :error_data

    category :error

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

      command = Messages::Commands::Record.new
      command.error_id = identifier.get
      command.hostname = host_info.hostname

      command.error = error_data

      command.time = clock.iso8601

      event_stream_name = stream_name(command.error_id)

      writer.write command, event_stream_name

      logger.info "Recoded error (#{LogText::RecordCommand.(command)})"

      return command, event_stream_name
    end

    def self.import_error(error)
      ErrorData::Convert::Error.(error)
    end

    module LogText
      module RecordCommand
        def self.call(command)
          "Error ID: #{command.error_id}, Error Message: #{command.error.message}, Time: #{command.time}, Hostname: #{command.hostname})"
        end
      end
    end
  end
end
