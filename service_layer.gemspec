# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'service_layer/version'

Gem::Specification.new do |spec|
  spec.name        = 'service_layer'
  spec.version     = ServiceLayer::Version::STRING
  spec.author      = 'Adrien Sasia -- Lefort des Ylouses'
  spec.email       = 'adriensldy@gmail.com'

  spec.summary     = 'Service Layer Pattern Implementation.'
  spec.description = <<-DESCRIPTION
    Encapsulate the application's business logic, controlling transactions and
    coordinating responses of operations.
  DESCRIPTION
  spec.license     = 'Apache-2.0'

  spec.metadata['bug_tracker_uri'] = 'https://github.com/gemologist/service_layer/issues'
  spec.metadata['changelog_uri']   = 'https://github.com/gemologist/service_layer/blob/master/CHANGELOG.md'
  spec.metadata['homepage_uri']    = 'https://github.com/gemologist/service_layer'
  spec.metadata['source_code_uri'] = 'https://github.com/gemologist/service_layer'

  spec.files = Dir['lib/**/*', '.yardopts', 'README.md', 'CHANGELOG.md',
                   'LICENSE']

  spec.required_ruby_version = '>= 2.3.7'

  spec.add_development_dependency 'rspec', '~> 3.6'
  spec.add_development_dependency 'rubocop', '~> 0.62.0'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.31'
  spec.add_development_dependency 'yard', '~> 0.9.9'
  spec.add_development_dependency 'yard-classmethods', '~> 1.0'
end
