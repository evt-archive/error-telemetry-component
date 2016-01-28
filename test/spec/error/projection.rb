require_relative '../spec_init'

context "Error Projection" do
  context "Recorded" do
    entity = ErrorTelemetryComponent::Entity.new
    projection = ErrorTelemetryComponent::Projection.new entity

    recorded = ErrorTelemetryComponent::Controls::Messages::Recorded.example

    projection.apply recorded

    context "Enttesty Data" do
      test "id" do
        assert(entity.id == recorded.error_id)
      end

      test "error" do
        assert(entity.error == recorded.error)
      end

      test "hostname" do
        assert(entity.hostname == recorded.hostname)
      end

      test "recorded_time" do
        assert(entity.recorded_time == recorded.time)
      end
    end
  end

  context "Published" do
    entity = ErrorTelemetryComponent::Entity.new
    projection = ErrorTelemetryComponent::Projection.new entity

    published = ErrorTelemetryComponent::Controls::Messages::Published.example

    projection.apply published

    context "Enttesty Data" do
      test "published_time" do
        assert(entity.published_time == published.time)
      end
    end
  end
end
