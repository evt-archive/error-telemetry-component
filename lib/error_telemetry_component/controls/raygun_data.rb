module ErrorTelemetryComponent
  module Controls
    module RaygunData
      def self.example(custom_data=nil, source=nil, time: nil)
        custom_data ||= { error_id: Controls::ID.example }
        RaygunClient::Controls::Data.example(custom_data, source, time: time)
      end
    end
  end
end
