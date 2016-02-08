# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'error_telemetry_component-client'
  s.version = '0.1.0'
  s.summary = 'Interface for processes to interact with the error-telemetry component'
  s.description = ' '

  s.authors = ['Obsidian Software, Inc']
  s.email = 'developers@obsidianexchange.com'
  s.homepage = 'https://github.com/obsidian-btc/sms-gateway'
  s.licenses = ['Not licensed for public use']

  s.require_paths = ['lib']
  s.files = Dir.glob 'lib/error_telemetry_component/{messages/commands/record.rb,host_info.rb,record.rb,record.rb,controls/error.rb,controls/record_error.rb,controls/source.rb,controls/time.rb,client/**/*.rb}'
  s.platform = Gem::Platform::RUBY
  s.bindir = 'bin'

  s.add_runtime_dependency 'eventide'
  s.add_runtime_dependency 'controls'
  s.add_runtime_dependency 'serialize'
end

