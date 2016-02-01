module ErrorTelemetryComponent
  module Controls
    module LapseTime
      def self.example(time=nil)
        time ||= ::Time.parse("Jan 1 1:00:00 Z 2000")
        Clock.iso8601(time)
      end
      singleton_class.send(:alias_method, :earlier, :example)

      def self.now(time=nil)
        time = Raw.example(time)
        Clock.iso8601(time)
      end
      singleton_class.send(:alias_method, :later, :now)

      def self.effective_seconds
        ErrorTelemetryComponent::Lapse::EffectiveTime.effective_seconds
      end

      module Raw
        def self.example(time=nil)
          time = LapseTime.example(time)

          time = ::Time.parse(time)
          time += (LapseTime.effective_seconds + 1)
          time
        end
        singleton_class.send(:alias_method, :later, :example)
      end
    end
  end
end

