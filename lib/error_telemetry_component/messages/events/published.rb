module ErrorTelemetryComponent
  module Messages
    module Events
      class Published
        include EventStore::Messaging::Message

        attribute :error_id
        attribute :time

        module LogText
          module Completion
            def self.call(event)
              "Published error (Error ID: #{event.error_id})"
            end
          end
        end
      end
    end
  end
end
