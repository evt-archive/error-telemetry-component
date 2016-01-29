module ErrorTelemetryComponent
  class Projection
    include EventStore::EntityProjection
    include Messages::Events

    apply Recorded do |event|
      SetAttributes.(entity, event, copy: [
        {:error_id => :id},
        :error,
        :hostname,
        {:time => :recorded_time}
      ])
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
