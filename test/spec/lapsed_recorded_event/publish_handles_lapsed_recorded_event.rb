require_relative '../spec_init'

context "Publish" do
  context "Recorded event has lapsed" do


    recorded_event = ErrorTelemetryComponent::Controls::Messages::Recorded::Lapsed.example

    now = ErrorTelemetryComponent::Controls::LapseTime.now

    substitute = [:clock, :writer, :raygun_post]
    publish_error = ErrorTelemetryComponent::Controls::PublishError.example(substitute: substitute)

    publish_error.clock.now = now

    writer = publish_error.writer

    raygun_post = publish_error.raygun_post
    raygun_sink = RaygunClient::HTTP::Post.register_telemetry_sink(raygun_post)

    publish_error.(recorded_event)

    test "Does not send the error to Raygun" do
      assert raygun_sink do
        posts.length == 0
      end
    end
  end
end
