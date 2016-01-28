module ErrorTelemetryComponent
  module Controls
    module PublishError
      def self.example(error_id=nil, substitute: nil, recorded_event: nil)
        error_id ||= Controls::ID.example
        substitutes = Array(substitute)

        publish_error = ErrorTelemetryComponent::Publish.build

        substitutes.each do |name|
          SubstAttr::Substitute.(name, publish_error)

          if name == :clock
            publish_error.clock.now = Controls::Time.example
          end
        end

        publish_error
      end
    end
  end
end
