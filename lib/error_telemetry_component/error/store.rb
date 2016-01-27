module ErrorTelemetryComponent
  module Error
    class Store
      include EventStore::EntityStore

      category 'error'
      entity Entity
      projection Projection
    end
  end
end
