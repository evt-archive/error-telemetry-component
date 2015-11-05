# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'telemetry'
  s.version = '0.0.0'
  s.summary = 'Telemetry recording and broadcast service'
  s.description = ' '

  s.authors = ['Obsidian Software, Inc']
  s.email = 'developers@obsidianexchange.com'
  s.homepage = 'https://github.com/obsidian-btc/telemetry'
  s.licenses = ['Not licensed for public use']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.2.3'

  s.add_runtime_dependency 'eventide', '~> 0'
  s.add_runtime_dependency 'error_data', '~> 0'
  s.add_runtime_dependency 'raygun_client', '~> 0'

  s.add_development_dependency 'minitest'
  s.add_development_dependency 'minitest-spec-context', '~> 0'
  s.add_development_dependency 'pry', '~> 0'
  s.add_development_dependency 'runner', '~> 0'
end



