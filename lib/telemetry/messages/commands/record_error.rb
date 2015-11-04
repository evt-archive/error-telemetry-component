module Telemetry
  module Errors
    module Messages
      class RecordError
        include EventStore::Messaging::Message
      end
    end
  end
end
