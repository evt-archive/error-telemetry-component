require_relative '../spec_init'

context "Store" do
  writer = EventStore::Messaging::Writer.build

  stream_name = TelemetryService::Controls::StreamName.get 'error'

  id = EventStore::Messaging::StreamName.get_id(stream_name)
  category_name = stream_name.split('-')[0]

  store = TelemetryService::Error::Store.build

  store.category_name = category_name

  context "Get Entity" do
    recorded = TelemetryService::Controls::Messages::Recorded.example
    error_data = ::Serialize::Write.raw_data(recorded.error, :json)
    recorded.error = error_data
    writer.write recorded, stream_name

    published = TelemetryService::Controls::Messages::Published.example
    writer.write published, stream_name

    enttesty = store.get id

    test "id" do
      assert(enttesty.attributes.values.any? { |v| !v.nil? })
    end
  end
end
