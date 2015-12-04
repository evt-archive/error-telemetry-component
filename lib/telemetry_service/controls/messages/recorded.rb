module TelemetryService
  module Controls
    module Messages
      module Recorded
        def self.example(error_id=nil)
          error_id ||= Controls::ID.example

          message = TelemetryService::Error::Messages::Events::Recorded.new

          message.error_id = error_id
          message.hostname = Controls::Host.name
          message.time = Controls::Time.example
          message.error = Controls::ErrorData.example

          message
        end
      end
    end
  end
end
