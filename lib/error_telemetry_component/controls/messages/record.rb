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
          message.error = ErrorData.data

          message
        end
      end
    end
  end
end
