module TelemetryService
  class Dispatcher
    include EventStore::Messaging::Dispatcher

    handler Handler
  end
end
