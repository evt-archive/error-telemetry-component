module TelemetryService
  module Error
    class Handler
      include EventStore::Messaging::Handler
      include EventStore::Messaging::StreamName
      include Messages::Events

      dependency :clock, Clock::UTC
      dependency :writer, EventStore::Messaging::Writer

      category :error

      def configure_dependencies
        Clock::UTC.configure self
        EventStore::Messaging::Writer.configure self
      end

      handle Recorded do |event|
        # actuate publish
      end

      # handle Publish do |command|
      # end

      # handle Published do |event|
      # end
    end
  end
end
