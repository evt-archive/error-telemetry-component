module ErrorTelemetryComponent
  class Dispatcher
    include EventStore::Messaging::Dispatcher

    handler Handlers::Record
    handler Handlers::Recorded
  end
end
