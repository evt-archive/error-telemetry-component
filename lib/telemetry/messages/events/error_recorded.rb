module Telemetry
  module Errors
    module Messages
      module Events
        class ErrorRecorded
          include EventStore::Messaging::Message
        end
      end
    end
  end
end
