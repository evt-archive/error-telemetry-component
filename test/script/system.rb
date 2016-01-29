require_relative './script_init'

error_id = Identifier::UUID::Random.get

command_message = ErrorTelemetryComponent::Controls::Messages::Record.example

writer = EventStore::Messaging::Writer.build
writer.write(command_message, "error-#{error_id}")
