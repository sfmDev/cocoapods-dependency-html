# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pretty_bacon/version'

Gem::Specification.new do |spec|
  spec.name          = "prettybacon"
  spec.version       = PrettyBacon::VERSION
  spec.authors       = ["Fabio A. Pelosin"]
  spec.email         = ["fabiopelosin@gmail.com"]
  spec.description   = %q{Prettifies Bacon output.}
  spec.summary       = %q{Prettifies Bacon output.}
  spec.homepage      = "https://github.com/irrationalfab/PrettyBacon"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency     "bacon",   "~> 1.2"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
