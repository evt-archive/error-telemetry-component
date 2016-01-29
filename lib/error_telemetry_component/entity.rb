module ErrorTelemetryComponent
  class Entity
    include Schema

    attribute :id
    attribute :error
    attribute :hostname
    attribute :recorded_time
    attribute :published_time
    attribute :lapsed_time

    def published?
      !published_time.nil?
    end

    def finished?
      !published_time.nil? || !lapsed_time.nil?
    end
  end
end
