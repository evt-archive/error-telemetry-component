module TelemetryService
  module Error
    module Messages
      module Commands
        class Publish
          include EventStore::Messaging::Message
        end
      end
    end
  end
end
