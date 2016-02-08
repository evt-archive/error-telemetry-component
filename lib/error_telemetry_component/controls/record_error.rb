module ErrorTelemetryComponent
  module Controls
    module RecordError
      def self.example(substitute: nil)
        substitutes = Array(substitute)

        error = Controls::Error.example
        source = Controls::Source.example

        record_error = ErrorTelemetryComponent::Client::Record.build(error, source)

        substitutes.each do |name|
          SubstAttr::Substitute.(name, record_error)

          if name == :host_info
            record_error.host_info.hostname = 'some hostname'
          end

          if name == :clock
            record_error.clock.now = ::Time.parse(Controls::Time.example)
          end
        end

        record_error
      end
    end
  end
end
