module TelemetryService
  module Controls
    module RecordError
      def self.example(substitute: nil)
        substitutes = Array(substitute)

        error = TelemetryService::Controls::Error.example

        record_error = TelemetryService::Error::Record.build(error)

        substitutes.each do |name|
          SubstAttr::Substitute.(name, record_error)

          if name == :host_info
            record_error.host_info.hostname = 'some hostname'
          end

          if name == :clock
            record_error.clock.now = Controls::Time.example
          end
        end

        record_error
      end
    end
  end
end
