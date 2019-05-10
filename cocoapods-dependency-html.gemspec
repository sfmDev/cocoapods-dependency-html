# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoapods-dependency-html/gem_version.rb'

Gem::Specification.new do |spec|
  spec.name          = 'cocoapods-dependency-html'
  spec.version       = CocoapodsDependencyHtml::VERSION
  spec.authors       = ['sfmDev']
  spec.email         = ['sfmdeveloper@icloud.com']
  spec.description   = %q{Show project dependencies with HTML file.}
  spec.summary       = %q{Show project dependencies with HTML file.}
  spec.homepage      = 'https://github.com/sfmDev/cocoapods-dependency-html'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'

  spec.add_dependency "launchy"
  spec.add_dependency 'cocoapods'
  spec.add_dependency 'json'
end
