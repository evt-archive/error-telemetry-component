module ErrorTelemetryComponent
  class Dispatcher
    include EventStore::Messaging::Dispatcher

    handler Handler
  end
end
