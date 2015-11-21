module Telemetry
  module Messages
    module Commands
      class RecordError
        include EventStore::Messaging::Message

        attribute :error
        attribute :machine_name
        attribute :time
      end
    end
  end
end
