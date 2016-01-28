module ErrorTelemetryComponent
  class Store
    include EventStore::EntityStore

    category 'error'
    entity Entity
    projection Projection
  end
end
