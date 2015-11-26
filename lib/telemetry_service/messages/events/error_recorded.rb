module TelemetryService
  module Messages
    module Events
      class ErrorRecorded
        include EventStore::Messaging::Message

        attribute :error_id
        attribute :error
        attribute :hostname
        attribute :time
      end
    end
  end
end
