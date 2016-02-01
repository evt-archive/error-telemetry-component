module ErrorTelemetryComponent
  module Messages
    module Events
      class Lapsed
        include EventStore::Messaging::Message

        attribute :error_id
        attribute :time

        module LogText
          module Completion
            def self.call(event)
              "Lapsed error - not published (Error ID: #{event.error_id})"
            end
          end
        end
      end
    end
  end
end
