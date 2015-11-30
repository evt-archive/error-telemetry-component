require_relative '../spec_init'

describe "Handle Error Published Event" do
  specify "Publishes the Error to Raygun" do
    handler = TelemetryService::Error::Handler.build

    event = TelemetryService::Controls::Messages::Recorded.example

    handler.handle_recorded(event)

    skip()
  end
end
