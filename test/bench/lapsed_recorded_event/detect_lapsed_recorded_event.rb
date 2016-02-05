require_relative '../bench_init'

context "Recorded event lapses" do
  recorded_event = ErrorTelemetryComponent::Controls::Messages::Recorded::Lapsed.example

  now = ErrorTelemetryComponent::Controls::LapseTime::Raw.later

  lapsed = recorded_event.lapsed?(now)

  test "After #{recorded_event.class.effective_hours} hours" do
    assert lapsed
  end
end
