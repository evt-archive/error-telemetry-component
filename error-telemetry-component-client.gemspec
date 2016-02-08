# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'error_telemetry_component-client'
  s.version = '0.0.1.0'
  s.summary = 'Interface for processes to interact with the error-telemetry component'
  s.description = ' '

  s.authors = ['Obsidian Software, Inc']
  s.email = 'developers@obsidianexchange.com'
  s.homepage = 'https://github.com/obsidian-btc/sms-gateway'
  s.licenses = ['Not licensed for public use']

  s.require_paths = ['lib']

  s.files = [
    'lib/error_telemetry_component/client/record.rb',
    'lib/error_telemetry_component/messages/commands/record.rb',
    'lib/error_telemetry_component/host_info.rb',
    'lib/error_telemetry_component/record.rb',
    'lib/error_telemetry_component/controls/error.rb',
    'lib/error_telemetry_component/controls/record_error.rb',
    'lib/error_telemetry_component/controls/source.rb',
    'lib/error_telemetry_component/controls/time.rb'
  ]
  s.platform = Gem::Platform::RUBY
  s.bindir = 'bin'

  s.add_runtime_dependency 'controls'
  s.add_runtime_dependency 'error_data'
  s.add_runtime_dependency 'eventide'
end

