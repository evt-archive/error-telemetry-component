require_relative '../spec_init'

describe "Error Projection" do
  context "Recorded" do
    entity = TelemetryService::Error::Entity.new
    projection = TelemetryService::Error::Projection.new entity

    recorded = TelemetryService::Controls::Messages::Recorded.example

    projection.apply recorded

    describe "Entity Data" do
      specify "id" do
        assert(entity.id == recorded.error_id)
      end

      specify "error" do
        assert(entity.error == recorded.error)
      end

      specify "hostname" do
        assert(entity.hostname == recorded.hostname)
      end

      specify "recorded_time" do
        assert(entity.recorded_time == recorded.time)
      end
    end
  end

  context "Published" do
    entity = TelemetryService::Error::Entity.new
    projection = TelemetryService::Error::Projection.new entity

    published = TelemetryService::Controls::Messages::Published.example

    projection.apply published

    describe "Entity Data" do
      specify "published_time" do
        assert(entity.published_time == published.time)
      end
    end
  end
end
