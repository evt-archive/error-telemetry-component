module Telemetry
  module Errors
    module Messages
      module Events
        class RecordedError
          include EventStore::Messaging::Message
        end
      end
    end
  end
end
