require_relative '../spec_init'

context "Publish an Error to Raygun" do
  recorded_event ||= ErrorTelemetryComponent::Controls::Messages::Recorded.example

  substitute = :clock
  publish_error = ErrorTelemetryComponent::Controls::PublishError.example(substitute: substitute)

  raygun_post = publish_error.raygun_post
  sink = RaygunClient::HTTP::Post.register_telemetry_sink(raygun_post)

  event, stream_name = publish_error.(recorded_event)

  test "Sends the error to Raygun" do
    assert(sink.recorded_posted?)
  end

  test "Writes published message" do
    path = "/streams/#{stream_name}"
    get = EventStore::Client::HTTP::Request::Get.build
    body_text, get_response = get.("#{path}/0")
    read_data = EventStore::Client::HTTP::EventData::Read.parse body_text

    assert(read_data.type == event.message_type)
  end
end
