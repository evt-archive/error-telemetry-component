module ErrorTelemetryComponent
  module Controls
    module RaygunData
      def self.example(custom_data=nil)
        custom_data ||= { error_id: Controls::ID.example }
        RaygunClient::Controls::Data.example(custom_data)
      end
    end
  end
end
