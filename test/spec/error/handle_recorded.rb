require_relative '../spec_init'

context "Handle Error Published Event" do
  handler = ErrorTelemetryComponent::Handler.build

  event = ErrorTelemetryComponent::Controls::Messages::Recorded.example

  publish = handler.handle_recorded(event)

  test "Publishes the error" #do
  #   publish.recorded_published?
  # end

  test "Writes the published event" #do
  #   publish.recorded_wrote_event?
  # end
end
