module ErrorTelemetryComponent
  module Controls
    module Messages
      module Lapsed
        def self.example(error_id=nil, time: nil)
          error_id ||= Controls::ID.example
          time ||= LapseTime.now_iso8601

          message = ErrorTelemetryComponent::Messages::Events::Lapsed.new

          message.error_id = error_id
          message.time = time

          message
        end
      end
    end
  end
end
