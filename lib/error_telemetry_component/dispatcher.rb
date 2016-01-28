module ErrorTelemetryComponent
  class Dispatcher
    include EventStore::Messaging::Dispatcher

    handler Handlers::Recorded
  end
end
