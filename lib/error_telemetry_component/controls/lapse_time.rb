module ErrorTelemetryComponent
  module Controls
    module LapseTime
      # Jan 1, 1:00:00 am
      def self.example(time=nil)
        time ||= ::Time.parse("Jan 1 1:00:00 Z 2000")
        Clock.iso8601(time)
      end

      def self.elapsed_time(time=nil)
        example(time)
      end

      # Jan 2, 1:00:01 am
      # TODO raw_now
      def self.now(time=nil)
        time = example(time)

        time = ::Time.parse(time)
        time += (effective_seconds + 1)
        time
      end

      # TODO now (ie: no 'iso8601' in control name)
      # TODO namespace iso time vs raw time
      def self.now_iso8601(time=nil)
        time = now(time)
        Clock.iso8601(time)
      end

      def self.effective_seconds
        ErrorTelemetryComponent::Lapse::EffectiveTime.effective_seconds
      end
    end
  end
end

