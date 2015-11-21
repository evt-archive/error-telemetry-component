module Telemetry
  class Handler
    include EventStore::Messaging::Handler
    include Messages::Commands
    include Messages::Events

    dependency :clock, Clock::UTC
    dependency :writer, EventStore::Messaging::Writer

    def configure_dependencies
      Clock::UTC.configure self
      EventStore::Messaging::Writer.configure self
    end

    handle RecordError do |command|
      event = ErrorRecorded.proceed command, copy: [
        :error,
        :machine_name
      ]

      event.recorded_time = command.time
      event.time = clock.now




    end

    handle ErrorRecorded do |event|
    end

    # handle PublishError do |event|

    # end
  end
end
