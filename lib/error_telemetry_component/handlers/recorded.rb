module ErrorTelemetryComponent
  module Handlers
    class Recorded
      include EventStore::Messaging::Handler
      include EventStore::Messaging::StreamName
      include Messages::Events

      dependency :clock, Clock::UTC
      dependency :writer, EventStore::Messaging::Writer
      dependency :publish, ErrorTelemetryComponent::Publish

      category :error

      def configure_dependencies
        Clock::UTC.configure self
        EventStore::Messaging::Writer.configure self
        ErrorTelemetryComponent::Publish.configure self
      end

      handle Recorded do |event|
        publish.(event)
      end
    end
  end
end
