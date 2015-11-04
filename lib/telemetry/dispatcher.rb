module Telemetry
  module Errors
    class Dispatcher
      include EventStore::Messaging::Dispatcher

      handler Handler
    end
  end
end
