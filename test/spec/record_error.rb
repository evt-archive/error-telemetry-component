require_relative 'spec_init'

describe "Recording an Error" do
  specify "Writes the recorded event" do
    error = Telemetry::Controls::Error.example

    SubstAttr::Substitute.(:writer, record_error)

    record_error.()

    __logger.focus record_error.inspect

    #assert something about the writer
  end
end
