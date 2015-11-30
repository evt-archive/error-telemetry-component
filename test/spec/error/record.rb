require_relative '../spec_init'

describe "Recording an Error" do
  substitutes = [:host_info, :clock]
  record_error = TelemetryService::Controls::RecordError.example(substitute: substitutes)

  event, stream_name = record_error.()

  path = "/streams/#{stream_name}"
  get = EventStore::Client::HTTP::Request::Get.build
  body_text, get_response = get.("#{path}/0")
  read_data = EventStore::Client::HTTP::EventData::Read.parse body_text

  context "Writes the recorded event" do
    specify "Event type" do
      assert(read_data.type == event.message_type)
    end

    specify "Error" do
      recorded_error = record_error.error_data
      recorded_error = ::Serialize::Write.raw_data(recorded_error, :json)
      recorded_error =Casing::Underscore.(recorded_error)

      read_error = read_data.data['error']

      assert(read_error == recorded_error)
    end

    specify "Hostname" do
      recorded_hostname = record_error.host_info.hostname
      read_hostname = read_data.data['hostname']

      assert(read_hostname == recorded_hostname)
    end

    specify "Time" do
      recorded_time = record_error.clock.now
      read_time = read_data.data['time']

      assert(read_time == recorded_time)
    end
  end
end
