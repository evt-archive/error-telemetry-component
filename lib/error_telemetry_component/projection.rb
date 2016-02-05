module ErrorTelemetryComponent
  class Projection
    include EventStore::EntityProjection
    include Messages::Events

    apply Recorded do |event|
      logger.todo "Remove special handling of error after event-store-messaging uses the serialize library [Nathan Ladd, Scott Bellware, Fri Feb 5 2016]"
      SetAttributes.(entity, event, copy: [
        {:error_id => :id},
        :hostname,
        {:time => :recorded_time}
      ])
      entity.error = event.error
    end

    apply Published do |event|
      SetAttributes.(entity, event, copy: [
        {:time => :published_time}
      ])
    end

    apply Lapsed do |event|
      SetAttributes.(entity, event, copy: [
        {:time => :lapsed_time}
      ])
    end
  end
end
