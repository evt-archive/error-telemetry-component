module Telemetry
  class RecordError
    attr_reader :error_data
    attr_reader :hostname

    dependency :logger, Telemetry::Logger
    dependency :clock, Clock::UTC
    dependency :writer, EventStore::Messaging::Writer

    def initialize(error_data, hostname)
      @error_data = error_data
      @hostname = hostname
    end

    def self.build(error)
      error_data = ErrorData::Import.(error)
      hostname = Socket.gethostname

      new(error_data, hostname).tap do |instance|
        Telemetry::Logger.configure instance
        Clock::UTC.configure instance
        EventStore::Messaging::Writer.configure instance
      end
    end



    def self.call(error)
      instance = build(error)
      time = instance.clock.now
      instance.(time)
    end

    def call(time=nil)
      time ||= clock.now
      # serialize the err data
      # add ID to event
      # send event to the writer
    end
  end
end
