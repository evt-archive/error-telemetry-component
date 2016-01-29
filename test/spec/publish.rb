require_relative './spec_init'

context "Publish an Error to Raygun" do
  recorded_event = ErrorTelemetryComponent::Controls::Messages::Recorded.example

  substitute = [:clock, :writer]
  publish_error = ErrorTelemetryComponent::Controls::PublishError.example(substitute: substitute)

  writer = publish_error.writer

  raygun_post = publish_error.raygun_post
  sink = RaygunClient::HTTP::Post.register_telemetry_sink(raygun_post)

  publish_error.(recorded_event)

  test "Sends the error to Raygun" do
    assert(sink.recorded_posted?)
  end

  test "Writes the published event" do
    published_event_control = ErrorTelemetryComponent::Controls::Messages::Published.example
    published_stream_name = ErrorTelemetryComponent::Controls::StreamName.get('error', published_event_control.error_id, random: false)

    assert(writer.written? do |event, stream_name|
      event == published_event_control &&
        stream_name == published_stream_name
    end)
  end
end
