module ErrorTelemetryComponent
  module Controls
    Error = ::ErrorData::Controls::Error

    module Error
      module Simulated
        class Error < StandardError; end

        def self.example(message=nil)
          message ||= self.message

          error = Simulated::Error.new message
          error.set_backtrace Controls::Error::Backtrace.example
          error
        end

        def self.message
          'Simulated error'
        end
      end
    end
  end
end
