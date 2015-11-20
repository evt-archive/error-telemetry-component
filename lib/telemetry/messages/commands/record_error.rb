module Telemetry
  module Errors
    module Messages
      module Commands
        class RecordError
          include EventStore::Messaging::Message

          attribute :error_data
        end
      end
    end
  end
end
