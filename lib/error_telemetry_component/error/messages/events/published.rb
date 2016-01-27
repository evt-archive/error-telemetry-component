module ErrorTelemetryComponent
  module Error
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
end
