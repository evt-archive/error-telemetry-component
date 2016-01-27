module ErrorTelemetryComponent
  class HostInfo
    def hostname
      self.class.hostname
    end

    def self.hostname
      Socket.gethostname
    end

    def self.configure(receiver)
      new.tap do |instance|
        receiver.host_info = instance
      end
    end

    module Substitute
      NullHostInfo = Struct.new(:hostname)

      def self.build
        NullHostInfo.new
      end
    end
  end
end
