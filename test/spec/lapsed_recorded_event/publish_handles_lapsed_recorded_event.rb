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

    test "Writes the lapsed event" do
      lapsed_event_control = ErrorTelemetryComponent::Controls::Messages::Lapsed.example
      published_stream_name = ErrorTelemetryComponent::Controls::StreamName.get('error', lapsed_event_control.error_id, random: false)

      assert writer do
        written? do |event, stream_name|

          event.metadata = nil

          __logger.focus lapsed_event_control.attributes.inspect
          __logger.focus event.attributes.inspect

          __logger.focus "control: #{lapsed_event_control.inspect}"
          __logger.focus "written: #{event.inspect}"


          event == lapsed_event_control &&
            stream_name == published_stream_name
        end
      end
    end

  end
end
