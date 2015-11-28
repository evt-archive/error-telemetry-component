module TelemetryService
  module Error
    class Store
      include EventStore::EntityStore
    end
  end
end
