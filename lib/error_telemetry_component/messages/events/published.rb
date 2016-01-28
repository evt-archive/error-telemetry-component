module ErrorTelemetryComponent
  module Messages
    module Events
      class Published
        include EventStore::Messaging::Message

        attribute :error_id
        attribute :time
      end
    end
  end
end
