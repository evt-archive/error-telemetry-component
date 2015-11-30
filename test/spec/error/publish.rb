require_relative '../spec_init'

describe "Publish an Error to Raygun" do
  substitute = :clock
  publish_error = TelemetryService::Controls::PublishError.example(substitute: substitute)

  # event, stream_name = record_error.()

  publish_error.()

  specify "Sends the error to Raygun" do
    skip()
  end

  # path = "/streams/#{stream_name}"
  # get = EventStore::Client::HTTP::Request::Get.build
  # body_text, get_response = get.("#{path}/0")
  # read_data = EventStore::Client::HTTP::EventData::Read.parse body_text

  # context "Writes the recorded event" do
  #   specify "Event type" do
  #     assert(read_data.type == event.message_type)
  #   end
  # end
end
