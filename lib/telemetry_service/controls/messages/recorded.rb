module TelemetryService
  module Controls
    module Messages
      module Recorded
        def self.example
          message = TelemetryService::Error::Messages::Events::Recorded.new

          message.error_id = Identifier::UUID::Controls::Random.example
          message.hostname = Controls::Host.name
          message.time = Controls::Time.example
          message.error = Controls::ErrorData::JSON.data

          message
        end
      end
    end
  end
end
