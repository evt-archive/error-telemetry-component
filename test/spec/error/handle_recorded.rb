require_relative '../spec_init'

context "Handle Error Published Event" do
  handler = TelemetryService::Error::Handler.build

  event = TelemetryService::Controls::Messages::Recorded.example

  handler.handle_recorded(event)

  test "Publishes the error to raygun" do
    __logger.focus "Not implemented"
  end

  test "Writes the published event" do
    __logger.focus "Not implemented"
  end
end
