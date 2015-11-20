module Telemetry
  module Errors
    class Handler
      include EventStore::Messaging::Handler
      include Messages::Commands
      include Messages::Events

      handle RecordError do |command|
      end

      handle ErrorRecorded do |command|
      end
    end
  end
end
