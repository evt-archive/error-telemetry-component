module TelemetryService
  module Error
    class Handler
      include EventStore::Messaging::Handler
      include Messages::Events

      dependency :clock, Clock::UTC
      dependency :writer, EventStore::Messaging::Writer

      def configure_dependencies
        Clock::UTC.configure self
        EventStore::Messaging::Writer.configure self
      end

      handle Recorded do |event|
      end

      # handle Publish do |command|
      # end

      # handle Published do |event|
      # end
    end
  end
end
