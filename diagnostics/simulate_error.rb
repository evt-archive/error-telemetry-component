require_relative './diagnostics_init'

source = ErrorTelemetryComponent::Controls::Source.example
error = ErrorTelemetryComponent::Controls::Error.example

record = ErrorTelemetryComponent::Record.build error, source
record.()
