module TelemetryService
  class Dispatcher
    include EventStore::Messaging::Dispatcher

    handler Error::Handler
  end
end
