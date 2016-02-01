module ErrorTelemetryComponent
  module Lapse
    extend self

    def self.included(cls)
      cls.extend EffectiveTime
    end

    def elapsed_milliseconds(now)
      Clock.elapsed_milliseconds(time, now)
    end

    module EffectiveTime
      extend self

      def effective_hours
        24
      end

      def effective_seconds
        effective_hours * 60 * 60
      end

      def effective_milliseconds
        effective_seconds * 1000
      end
    end
  end
end
