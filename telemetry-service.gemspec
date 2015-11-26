# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'telemetry_service'
  s.version = '0.0.0'
  s.summary = 'Telemetry recording and broadcast service, including error reporting and integration with third-party reporting services'
  s.description = ' '

  s.authors = ['Obsidian Software, Inc']
  s.email = 'developers@obsidianexchange.com'
  s.homepage = 'https://github.com/obsidian-btc/telemetry'
  s.licenses = ['Not licensed for public use']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.2.3'

  s.add_runtime_dependency 'eventide'
  s.add_runtime_dependency 'initializer'
  s.add_runtime_dependency 'raygun_client'

  s.add_development_dependency 'minitest'
  s.add_development_dependency 'minitest-spec-context'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'runner'
end
