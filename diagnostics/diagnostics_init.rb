ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['LOG_COLOR'] ||= 'on'
ENV['LOGGER'] ||= 'on'
ENV['LOG_LEVEL'] ||= 'debug'

puts RUBY_DESCRIPTION

require_relative '../init.rb'

require 'error_telemetry_component/controls'

Telemetry::Logger::AdHoc.activate
