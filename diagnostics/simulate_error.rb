require_relative './diagnostics_init'

source = 'error-telemetry'

error = ErrorTelemetryComponent::Controls::Error::Simulated.example

record = ErrorTelemetryComponent::Record.build error, source
record.()
