require 'pp'
require_relative '../spec_init'

context "Building Recorded Event from Raw Data" do
  test "Converts the error data to an ErrorData instance" do
    compare_recorded_event = ErrorTelemetryComponent::Controls::Messages::Recorded.example

    data = ErrorTelemetryComponent::Controls::Messages::Recorded.data
    recorded_event = ErrorTelemetryComponent::Error::Messages::Events::Recorded.build data

    assert(recorded_event == compare_recorded_event)
  end
end
