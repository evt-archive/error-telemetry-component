ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['LOG_COLOR'] ||= 'on'

if ENV['LOG_LEVEL']
  ENV['LOGGER'] ||= 'on'
else
  ENV['LOG_LEVEL'] ||= 'trace'
end

ENV['LOGGER'] ||= 'off'

puts RUBY_DESCRIPTION

require_relative '../client_init'

require 'error_telemetry_component/client/controls'

Telemetry::Logger::AdHoc.activate
