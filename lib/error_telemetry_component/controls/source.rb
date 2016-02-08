module ErrorTelemetryComponent
  module Controls
    module Source
      def self.example
        RaygunClient::Controls::Data.source
      end
    end
  end
end
