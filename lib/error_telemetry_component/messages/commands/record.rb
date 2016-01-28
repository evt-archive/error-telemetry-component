module ErrorTelemetryComponent
  module Messages
    module Commands
      class Record
        include EventStore::Messaging::Message

        attribute :error_id
        attribute :error
        attribute :hostname
        attribute :time
      end
    end
  end
end
