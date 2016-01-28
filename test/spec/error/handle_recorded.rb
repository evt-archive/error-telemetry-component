require_relative '../spec_init'

context "Handle Published Event" do
  handler = ErrorTelemetryComponent::Handlers::Recorded.build

  publish = ErrorTelemetryComponent::Controls::PublishError.example substitute: [:raygun_post, :writer]
  sink = ErrorTelemetryComponent::Publish.register_telemetry_sink(publish)

  handler.publish = publish

  event = ErrorTelemetryComponent::Controls::Messages::Recorded.example
  handler.handle_recorded(event)

  test "Publishes the error" do
    assert(sink.recorded_published?)
  end

  test "Writes the published event" do
    assert(sink.recorded_wrote_event?)
  end
end
