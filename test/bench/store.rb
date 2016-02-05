require_relative './bench_init'

context "Store" do
  writer = EventStore::Messaging::Writer.build

  stream_name = ErrorTelemetryComponent::Controls::StreamName.get 'error'

  id = EventStore::Messaging::StreamName.get_id(stream_name)
  category_name = stream_name.split('-')[0]

  store = ErrorTelemetryComponent::Store.build

  store.category_name = category_name

  context "Get Entity" do
    recorded = ErrorTelemetryComponent::Controls::Messages::Recorded.example
    writer.write recorded, stream_name

    published = ErrorTelemetryComponent::Controls::Messages::Published.example
    writer.write published, stream_name

    entity = store.get id

    test "id" do
      assert(entity.attributes.values.any? { |v| !v.nil? })
    end
  end
end
