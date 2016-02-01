require_relative '../spec_init'

context "Recorded event lapses" do
  control = ErrorTelemetryComponent::Controls::Messages::Recorded::Lapsed
  recorded_event = control.example
  now = control.now

  lapsed = recorded_event.lapsed?(now)

  test "After #{recorded_event.class.effective_hours} hours" do
    assert lapsed
  end
end
