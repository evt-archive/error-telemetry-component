module ErrorTelemetryComponent
  module Controls
    module LapseTime
      def self.example(time=nil)
        time ||= ::Time.parse("Jan 1 1:00:00 Z 2000")
        Clock.iso8601(time)
      end

      def self.now(time=nil)
        time = example(time)

        time = ::Time.parse(time)
        time += (effective_seconds + 1)
        time
      end

      def self.effective_seconds
        ErrorTelemetryComponent::Lapse::EffectiveTime.effective_seconds
      end
    end
  end
end

