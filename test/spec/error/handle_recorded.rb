require_relative '../spec_init'

context "Handle Error Published Event" do
  handler = ErrorTelemetryComponent::Error::Handler.build

  event = ErrorTelemetryComponent::Controls::Messages::Recorded.example

  handler.handle_recorded(event)

  test "Publishes the error to raygun" do
    raise "Not implemented"
  end

  test "Writes the published event" do
    raise "Not implemented"
  end
end
