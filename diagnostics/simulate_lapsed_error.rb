require_relative './diagnostics_init'

source = 'error-telemetry'

error = ErrorTelemetryComponent::Controls::Error::Simulated.example('Simulated lapsed error')

record = ErrorTelemetryComponent::Record.build error, source

SubstAttr::Substitute.(:clock, record)
record.clock.now = Controls::Time::Raw.example
record.()
