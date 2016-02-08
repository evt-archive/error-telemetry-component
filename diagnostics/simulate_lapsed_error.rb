require_relative './diagnostics_init'

error = ErrorTelemetryComponent::Controls::Error.example

record = ErrorTelemetryComponent::Record.build error, 'error-telemetry'

SubstAttr::Substitute.(:clock, record)
record.clock.now = Controls::Time::Raw.example
record.()
