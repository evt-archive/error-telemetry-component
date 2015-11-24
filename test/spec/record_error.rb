require_relative 'spec_init'

describe "Recording an Error" do
  specify "Writes the recorded event" do
    # substitutes = [:writer, :host_info]
    substitutes = [:host_info]

    record_error = Telemetry::Controls::RecordError.example(substitute: substitutes)

    event = record_error.()

    if substitutes.include? :writer
      writer = record_error.writer

      written = writer.written? do |msg|
        msg.class == Telemetry::Messages::Events::ErrorRecorded
      end

      assert(written)
    end

    assert(event.class == Telemetry::Messages::Events::ErrorRecorded)
  end
end
