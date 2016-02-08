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
  s.files = Dir.glob 'lib/error_telemetry_component/{client.rb,host_info.rb,messages/commands/record.rb,record.rb,client/**/*.rb,controls/client.rb}'
  s.platform = Gem::Platform::RUBY
  s.bindir = 'bin'

  s.add_runtime_dependency 'eventide'
  s.add_runtime_dependency 'controls'
  s.add_runtime_dependency 'serialize'
end

