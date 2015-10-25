module Telemetry
  module Errors
    module Messages
      class RecordErrors
        include EventStore::Messaging::Message
      end
    end
  end
end
