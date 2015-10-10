ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['LOG_COLOR'] ||= 'on'
ENV['LOG_LEVEL'] ||= 'trace'

puts RUBY_DESCRIPTION

require_relative '../init.rb'
require 'runner'
require 'fixture'
require 'clock'
require 'pry'
require 'uuid'

require 'account/controls'

TestLogger = Telemetry::Logger.get 'Test Output'
