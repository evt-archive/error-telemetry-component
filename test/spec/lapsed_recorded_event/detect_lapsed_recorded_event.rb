require_relative '../spec_init'

context "Recorded event lapses" do
  recorded_event = ErrorTelemetryComponent::Controls::Messages::Recorded::Lapsed.example

  now = ErrorTelemetryComponent::Controls::LapseTime.now

  lapsed = recorded_event.lapsed?(now)

  test "After #{recorded_event.class.effective_hours} hours" do
    assert lapsed
  end
end
