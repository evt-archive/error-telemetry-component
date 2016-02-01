require_relative '../spec_init'

context "Publish" do
  context "Recorded event has lapsed" do
    test do
      # handler clock is set to time + lapse interval
      # send recorded event
      # writes NotPublished
      # Note: projection: entity picks up the Lapsed time
      # from the Lapsed event


      recorded_event = ErrorTelemetryComponent::Controls::Messages::Recorded::Lapsed.example

      now = ErrorTelemetryComponent::Controls::LapseTime.now

      substitute = [:clock, :writer, :raygun_post]
      publish_error = ErrorTelemetryComponent::Controls::PublishError.example(substitute: substitute)

      publish_error.clock.now = now
    end
  end
end
