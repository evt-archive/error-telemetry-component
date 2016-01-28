module ErrorTelemetryComponent
  module Handlers
    class Publish
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

      # handle Publish do |command|
      # end
    end
  end
end
