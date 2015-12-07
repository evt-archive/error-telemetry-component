require_relative '../spec_init'

describe "Handle Error Published Event" do
  handler = TelemetryService::Error::Handler.build

  event = TelemetryService::Controls::Messages::Recorded.example

  handler.handle_recorded(event)

  specify "Publishes the error to raygun" do
    skip()
  end

  specify "Writes the published event" do
    skip()
  end
end
