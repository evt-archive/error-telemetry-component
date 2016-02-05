module ErrorTelemetryComponent
  module Controls
    module Messages
      module Record
        def self.example
          error_id = Controls::ID.example

          message = ErrorTelemetryComponent::Messages::Commands::Record.new

          message.error_id = error_id
          message.hostname = Controls::Host.name
          message.time = Controls::Time.example
          message.error = ErrorData.example

          message
        end

        def self.data
          data = {}

          data[:error_id] = Controls::ID.example
          data[:hostname] = Controls::Host.name
          data[:time] = Controls::Time.example
          data[:error] = ErrorData.data

          data
        end
      end
    end
  end
end
