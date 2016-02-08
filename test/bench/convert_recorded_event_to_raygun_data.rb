require_relative './bench_init'

context "Convert Recorded Event to Raygun Data" do
  control_raygun_data = ErrorTelemetryComponent::Controls::RaygunData.example

  recorded_event = ErrorTelemetryComponent::Controls::Messages::Recorded.example

  raygun_data = ErrorTelemetryComponent::ConvertErrorData::RaygunData.(recorded_event)

  test "Event is converted to Raygun data" do
    assert(raygun_data == control_raygun_data)
  end
end
