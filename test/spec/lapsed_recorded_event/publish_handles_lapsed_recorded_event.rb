require_relative '../spec_init'

context "Publish" do
  context "Recorded event has lapsed" do
    test #do
      # handler clock is set to time + lapse interval
      # send recorded event
      # writes NotPublished
      # Note: projection: entity picks up the Lapsed time
      # from the Lapsed event


      # recorded_event = ErrorTelemetryComponent::Controls::Messages::Recorded.example

      # recorded_time = Time.parse("Jan 1 1:00:00 GMT 2000")
      # recorded_event.time = Clock.iso8601(recorded_time)

      # now = Time.parse("Jan 2 1:00:01 GMT 2000")

    # end
  end
end
