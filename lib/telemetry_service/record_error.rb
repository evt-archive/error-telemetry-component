module TelemetryService
  class RecordError
    include EventStore::Messaging::StreamName
    include Messages::Events

    initializer :error_data

    dependency :logger, Telemetry::Logger
    dependency :clock, Clock::UTC
    dependency :identifier, Identifier::UUID::Random
    dependency :host_info, HostInfo
    dependency :writer, EventStore::Messaging::Writer

    category 'error'

    def self.build(error)
      error_data = import_error(error)

      new(error_data).tap do |instance|
        Telemetry::Logger.configure instance
        Clock::UTC.configure instance
        Identifier::UUID::Random.configure instance
        TelemetryService::HostInfo.configure instance
        EventStore::Messaging::Writer.configure instance
      end
    end

    def self.call(error)
      instance = build(error)
      time = instance.clock.now
      instance.(time)
    end

    def call(time: nil, hostname: nil)
      time ||= clock.now
      hostname ||= host_info.hostname

      event = ErrorRecorded.new
      event.error_id = identifier.get
      event.hostname = hostname
      event.time = time

      #!!! serialize the err data
      event.error = error_data.to_h



      event_stream_name = stream_name event.error_id

      writer.write event, event_stream_name

      event
    end

    def self.import_error(error)
      ErrorData::Import.(error)
    end
  end
end
