module ErrorTelemetryComponent
  module Controls
    module Messages
      module Published
        def self.example(error_id=nil, time: nil)
          error_id ||= Controls::ID.example
          time ||= Controls::Time.example

          message = ErrorTelemetryComponent::Messages::Events::Published.new

          message.error_id = error_id
          message.time = time

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
