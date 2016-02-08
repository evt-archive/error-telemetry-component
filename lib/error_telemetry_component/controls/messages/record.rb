module ErrorTelemetryComponent
  module Controls
    module Messages
      module Record
        def self.example
          error_id = Controls::ID.example

          message = ErrorTelemetryComponent::Messages::Commands::Record.new

          message.error_id = error_id
          message.time = Controls::Time.example
          message.source = Controls::Source.example
          message.hostname = Controls::Host.name
          message.error = ErrorData.example

          message
        end

        def self.data
          data = {}

          data[:error_id] = Controls::ID.example
          data[:time] = Controls::Time.example
          data[:source] = Controls::Source.example
          data[:hostname] = Controls::Host.name
          data[:error] = ErrorData.data

          data
        end
      end
    end
  end
end
