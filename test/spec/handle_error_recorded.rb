require_relative 'spec_init'

describe "Handle Error Recorded" do
  specify "Issues publish command" do
    handler = TelemetryService::Error::Handler.build
  end
end
