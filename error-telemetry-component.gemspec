# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'error_telemetry_component'
  s.version = '0.0.0.0'
  s.summary = 'Error telemetry recording and publishing component'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/obsidian-btc/telemetry'
  s.licenses = ['Not licensed for public use']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.2.3'

  s.add_runtime_dependency 'controls'
  s.add_runtime_dependency 'eventide'
  s.add_runtime_dependency 'initializer'
  s.add_runtime_dependency 'process_host'
  s.add_runtime_dependency 'raygun_client'

  s.add_development_dependency 'test_bench'
end
