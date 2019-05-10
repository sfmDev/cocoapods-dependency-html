# -*- encoding: utf-8 -*-
# stub: mocha-on-bacon 0.2.3 ruby lib

Gem::Specification.new do |s|
  s.name = "mocha-on-bacon".freeze
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Eloy Duran".freeze]
  s.date = "2016-11-12"
  s.description = "A Mocha adapter for Bacon, because it's yummy!".freeze
  s.email = "eloy.de.enige@gmail.com".freeze
  s.extra_rdoc_files = ["LICENSE".freeze, "README.md".freeze]
  s.files = ["LICENSE".freeze, "README.md".freeze]
  s.homepage = "https://github.com/alloy/mocha-on-bacon".freeze
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.rubygems_version = "2.7.6".freeze
  s.summary = "A Mocha adapter for Bacon".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mocha>.freeze, [">= 0.13.0"])
    else
      s.add_dependency(%q<mocha>.freeze, [">= 0.13.0"])
    end
  else
    s.add_dependency(%q<mocha>.freeze, [">= 0.13.0"])
  end
end
