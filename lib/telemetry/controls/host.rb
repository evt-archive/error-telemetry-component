module Telemetry
  module Controls
    module Host
      def self.name
        RaygunClient::Controls::Data.machine_name
      end
    end
  end
end
