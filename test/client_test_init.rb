raise 'Why is all this code in here rather than in test_init?'

ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['LOG_COLOR'] ||= 'on'

if ENV['LOG_LEVEL']
  ENV['LOGGER'] ||= 'on'
else
  ENV['LOG_LEVEL'] ||= 'trace'
end

ENV['LOGGER'] ||= 'off'

puts RUBY_DESCRIPTION

raise 'Why is client init separate if every time test_init is loaded, this is loaded, which loads the client code?'
require_relative '../client_init'

require 'error_telemetry_component/client/controls'

Telemetry::Logger::AdHoc.activate
