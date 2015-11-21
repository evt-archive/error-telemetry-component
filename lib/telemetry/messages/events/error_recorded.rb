module Telemetry
  module Messages
    module Events
      class ErrorRecorded
        include EventStore::Messaging::Message

        attribute :error
        attribute :machine_name
        attribute :time
      end
    end
  end
end
