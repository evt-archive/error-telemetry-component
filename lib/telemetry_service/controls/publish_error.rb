module TelemetryService
  module Controls
    module PublishError
      def self.example(error_id=nil, substitute: nil)
        error_id ||= ::Controls::ID.get
        substitutes = Array(substitute)

        error_data = TelemetryService::Controls::ErrorData.example

        publish_error = TelemetryService::Error::Publish.build(error_id, error_data)

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
