module TelemetryService
  module Controls
    module Messages
      module Published
        def self.example(error_id=nil)
          error_id ||= Controls::ID.example

          message = TelemetryService::Error::Messages::Events::Published.new

          message.error_id = error_id
          message.time = Controls::Time.example

          message
        end

        def self.data
          data = {}

          data[:error_id] = Controls::ID.example
          data[:time] = Controls::Time.example

          data
        end
      end
    end
  end
end
