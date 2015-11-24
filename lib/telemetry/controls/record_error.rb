module Telemetry
  module Controls
    module RecordError
      def self.example(substitute: nil)
        substitutes = Array(substitute)

        error = Telemetry::Controls::Error.example

        record_error = Telemetry::RecordError.build(error)

        substitutes.each do |name|
          SubstAttr::Substitute.(name, record_error)

          if name == :host_info
            record_error.host_info.hostname = 'some hostname'
          end
        end

        record_error
      end
    end
  end
end
