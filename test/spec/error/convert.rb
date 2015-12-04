require_relative '../spec_init'

describe "Convert Recorded Event to Raygun Data" do
  compare_raygun_data = TelemetryService::Controls::RaygunData.example

  recorded_event = TelemetryService::Controls::Messages::Recorded.example

  raygun_data = TelemetryService::Error::ConvertErrorData.(recorded_event)

  specify do
    assert(raygun_data == compare_raygun_data)
  end
end
