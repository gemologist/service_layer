# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'service_layer/version'

Gem::Specification.new do |spec|
  spec.name        = 'service_layer'
  spec.version     = ServiceLayer::Version::STRING
  spec.author      = 'AdrienSldy'
  spec.email       = 'adriensldy@gmail.com'

  spec.summary     = 'Service Layer Pattern Implementation.'
  spec.description = <<-DESCRIPTION
    Provide an easy way to write service layer object.
    Services are used to encapsulate application logic business.
  DESCRIPTION
  spec.homepage    = 'https://github.com/gemologist/service_layer'
  spec.license     = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/gemologist/service_layer/'
  spec.metadata['changelog_uri'] = 'https://github.com/gemologist/service_layer/blob/master/CHANGELOG.md'
  spec.metadata['bug_tracker_uri'] = 'https://github.com/gemologist/service_layer/issues'

  spec.files = Dir['lib/**/*']

  spec.required_ruby_version = '>= 2.2.8'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rspec', '~> 3.6'
  spec.add_development_dependency 'rubocop', '~> 0.50.0'
end
