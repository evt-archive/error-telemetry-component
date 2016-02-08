require_relative '../client_bench_init'

context "Recording an Error" do
  substitute = [:host_info, :clock]
  record_error = ErrorTelemetryComponent::Client::Controls::RecordError.example(substitute: substitute)

  event, stream_name = record_error.()

  path = "/streams/#{stream_name}"
  get = EventStore::Client::HTTP::Request::Get.build
  body_text, get_response = get.("#{path}/0")
  read_data = EventStore::Client::HTTP::EventData::Read.parse body_text

  context "Writes the recorded event" do
    test "Event Type" do
      assert(read_data.type == event.message_type)
    end

    test "error" do
      read_error = read_data.data['error']

      recorded_error = record_error.error_data
      recorded_error = ::Serialize::Write.raw_data(recorded_error)
      recorded_error = Casing::Underscore.(recorded_error, symbol_to_string: true)

      assert(read_error == recorded_error)
    end

    test "hostname" do
      recorded_hostname = record_error.host_info.hostname
      read_hostname = read_data.data['hostname']

      assert(read_hostname == recorded_hostname)
    end

    test "source" do
      recorded_source = record_error.source
      read_source = read_data.data['source']

      assert(read_source == recorded_source)
    end

    test "time" do
      recorded_time = record_error.clock.iso8601
      read_time = read_data.data['time']

      assert(read_time == recorded_time)
    end
  end
end
