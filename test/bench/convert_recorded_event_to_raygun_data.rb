require_relative './spec_init'

context "Convert Recorded Event to Raygun Data" do
  compare_raygun_data = ErrorTelemetryComponent::Controls::RaygunData.example

  recorded_event = ErrorTelemetryComponent::Controls::Messages::Recorded.example

  raygun_data = ErrorTelemetryComponent::ConvertErrorData.(recorded_event)

  test "Event is converted to Raygun data" do
    assert(raygun_data == compare_raygun_data)
  end
end
