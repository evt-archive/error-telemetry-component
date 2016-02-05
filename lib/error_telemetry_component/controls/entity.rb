module ErrorTelemetryComponent
  module Controls
    module Entity
      def self.example(published_time: nil)
        error_id = ID.example
        error = Controls::Error.example
        hostname = Controls::Host.name
        recorded_time = Controls::Time.reference

        entity = ErrorTelemetryComponent::Entity.new
        SetAttributes.(
          entity,
          :id => error_id,
          :error => error,
          :hostname => hostname,
          :recorded_time => recorded_time,
          :published_time => published_time
        )
        entity
      end

      module Finished
        def self.example
          published_time = Controls::Time.reference
          Entity.example published_time: published_time
        end
      end
    end
  end
end
