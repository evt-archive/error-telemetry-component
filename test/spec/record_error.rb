require_relative 'spec_init'

describe "Recording an Error" do
  specify "Writes the recorded event" do
    # substitutes = [:writer, :host_info]
    substitutes = [:host_info]

    record_error = TelemetryService::Controls::RecordError.example(substitute: substitutes)

    writer = record_error.writer
    sink = EventStore::Messaging::Writer.register_telemetry_sink(writer)

    event = record_error.()

    assert(sink.recorded_written? { |r| r.data.message.class == TelemetryService::Error::Messages::Events::Recorded })
  end
end
