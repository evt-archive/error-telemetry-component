require_relative './bench_init'

context "Handle Record Command" do
  handler = ErrorTelemetryComponent::Handlers::Record.new

  error = ErrorTelemetryComponent::Controls::Error.example
  record_command = ErrorTelemetryComponent::Controls::Messages::Record.example

  context "Records the error" do
    test do
      expected_event = ErrorTelemetryComponent::Controls::Messages::Recorded.example

      handler.handle_record record_command

      assert handler.writer do
        written? do |event|
          event == expected_event
        end
      end
    end

    test "Writes the initial message" do
      handler.handle_record record_command

      assert handler.writer do
        written? do |_, _, version|
          version == :no_stream
        end
      end
    end
  end
end
