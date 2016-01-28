module ErrorTelemetryComponent
  module Controls
    module Handlers
      module Recorded
        def self.example(substitute: nil)
          substitutes = Array(substitute)

          handler = ErrorTelemetryComponent::Handlers::Recorded.build

          substitutes.each do |name|
            SubstAttr::Substitute.(name, handler)
          end

          handler
        end
      end
    end
  end
end
