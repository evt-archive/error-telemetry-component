require_relative './spec_init'

context "Recorded event lapses" do
  recorded_event = ErrorTelemetryComponent::Controls::Messages::Recorded.example

  recorded_time = Time.parse("Jan 1 1:00:00 GMT 2000")
  recorded_event.time = Clock.iso8601(recorded_time)

  now = Time.parse("Jan 2 1:00:01 GMT 2000")
  lapsed = recorded_event.lapsed?(now)

  test "After #{recorded_event.class.effective_hours} hours" do
    assert lapsed
  end
end
