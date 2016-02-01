module ErrorTelemetryComponent
  module Controls
    module RaygunData
      def self.example(custom_data=nil, time: nil)
        custom_data ||= { error_id: Controls::ID.example }
        RaygunClient::Controls::Data.example(custom_data, time: time)
      end
    end
  end
end
