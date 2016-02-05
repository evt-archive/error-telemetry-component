require_relative './bench_init'

context "Publish" do
  context "Publish an Error to Raygun" do
    time = ErrorTelemetryComponent::Controls::LapseTime.example
    recorded_event = ErrorTelemetryComponent::Controls::Messages::Recorded.example(time: time)

    substitute = [:clock, :writer, :raygun_post]
    publish_error = ErrorTelemetryComponent::Controls::PublishError.example(substitute: substitute)

    publish_error.clock.now = Time.parse(time)

    writer = publish_error.writer

    raygun_post = publish_error.raygun_post
    raygun_sink = RaygunClient::HTTP::Post.register_telemetry_sink(raygun_post)

    publish_error.(recorded_event)

    test "Sends the error to Raygun" do
      control_data = ErrorTelemetryComponent::Controls::RaygunData.example(time: time)

      assert raygun_sink do
        posted? do |data|
          data == control_data
        end
      end
    end

    test "Writes the published event" do
      published_event_control = ErrorTelemetryComponent::Controls::Messages::Published.example(time: time)
      published_stream_name = ErrorTelemetryComponent::Controls::StreamName.get('error', published_event_control.error_id, random: false)

      assert writer do
        written? do |event, stream_name|
          event.attributes == published_event_control.attributes &&
            stream_name == published_stream_name
        end
      end
    end
  end
end
