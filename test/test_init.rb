ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['LOG_COLOR'] ||= 'on'
ENV['LOG_LEVEL'] ||= 'trace'
ENV['ENTITY_CACHE_SCOPE'] ||= 'exclusive'

puts RUBY_DESCRIPTION

require_relative '../init.rb'

require 'test_bench'; TestBench.activate
require 'telemetry_service/controls'

Telemetry::Logger::AdHoc.activate
