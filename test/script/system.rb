require_relative './script_init'

error = ErrorTelemetryComponent::Controls::Error.example

ErrorTelemetryComponent::Record.(error)
