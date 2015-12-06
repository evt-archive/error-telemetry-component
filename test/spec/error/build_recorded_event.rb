require 'pp'
require_relative '../spec_init'

describe "Building Recorded Event from Raw Data" do
  specify "Converts the error data to an ErrorData instance" do
    compare_recorded_event = TelemetryService::Controls::Messages::Recorded.example

    data = TelemetryService::Controls::Messages::Recorded.data
    recorded_event = TelemetryService::Error::Messages::Events::Recorded.build data

    assert(recorded_event == compare_recorded_event)
  end
end
