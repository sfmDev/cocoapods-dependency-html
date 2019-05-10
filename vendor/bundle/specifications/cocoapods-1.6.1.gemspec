# -*- encoding: utf-8 -*-
# stub: cocoapods 1.6.1 ruby lib

Gem::Specification.new do |s|
  s.name = "cocoapods".freeze
  s.version = "1.6.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Eloy Duran".freeze, "Fabio Pelosin".freeze, "Kyle Fuller".freeze, "Samuel Giddins".freeze]
  s.date = "2019-02-21"
  s.description = "CocoaPods manages library dependencies for your Xcode project.\n\nYou specify the dependencies for your project in one easy text file. CocoaPods resolves dependencies between libraries, fetches source code for the dependencies, and creates and maintains an Xcode workspace to build your project.\n\nUltimately, the goal is to improve discoverability of, and engagement in, third party open-source libraries, by creating a more centralized ecosystem.".freeze
  s.email = ["eloy.de.enige@gmail.com".freeze, "fabiopelosin@gmail.com".freeze, "kyle@fuller.li".freeze, "segiddins@segiddins.me".freeze]
  s.executables = ["pod".freeze, "sandbox-pod".freeze]
  s.files = ["bin/pod".freeze, "bin/sandbox-pod".freeze]
  s.homepage = "https://github.com/CocoaPods/CocoaPods".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.rubygems_version = "2.7.6".freeze
  s.summary = "The Cocoa library package manager.".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<cocoapods-core>.freeze, ["= 1.6.1"])
      s.add_runtime_dependency(%q<claide>.freeze, ["< 2.0", ">= 1.0.2"])
      s.add_runtime_dependency(%q<cocoapods-deintegrate>.freeze, ["< 2.0", ">= 1.0.2"])
      s.add_runtime_dependency(%q<cocoapods-downloader>.freeze, ["< 2.0", ">= 1.2.2"])
      s.add_runtime_dependency(%q<cocoapods-plugins>.freeze, ["< 2.0", ">= 1.0.0"])
      s.add_runtime_dependency(%q<cocoapods-search>.freeze, ["< 2.0", ">= 1.0.0"])
      s.add_runtime_dependency(%q<cocoapods-stats>.freeze, ["< 2.0", ">= 1.0.0"])
      s.add_runtime_dependency(%q<cocoapods-trunk>.freeze, ["< 2.0", ">= 1.3.1"])
      s.add_runtime_dependency(%q<cocoapods-try>.freeze, ["< 2.0", ">= 1.1.0"])
      s.add_runtime_dependency(%q<molinillo>.freeze, ["~> 0.6.6"])
      s.add_runtime_dependency(%q<xcodeproj>.freeze, ["< 2.0", ">= 1.8.1"])
      s.add_runtime_dependency(%q<activesupport>.freeze, ["< 5", ">= 4.0.2"])
      s.add_runtime_dependency(%q<colored2>.freeze, ["~> 3.1"])
      s.add_runtime_dependency(%q<escape>.freeze, ["~> 0.0.4"])
      s.add_runtime_dependency(%q<fourflusher>.freeze, ["< 3.0", ">= 2.2.0"])
      s.add_runtime_dependency(%q<gh_inspector>.freeze, ["~> 1.0"])
      s.add_runtime_dependency(%q<nap>.freeze, ["~> 1.0"])
      s.add_runtime_dependency(%q<ruby-macho>.freeze, ["~> 1.4"])
      s.add_development_dependency(%q<bacon>.freeze, ["~> 1.1"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    else
      s.add_dependency(%q<cocoapods-core>.freeze, ["= 1.6.1"])
      s.add_dependency(%q<claide>.freeze, ["< 2.0", ">= 1.0.2"])
      s.add_dependency(%q<cocoapods-deintegrate>.freeze, ["< 2.0", ">= 1.0.2"])
      s.add_dependency(%q<cocoapods-downloader>.freeze, ["< 2.0", ">= 1.2.2"])
      s.add_dependency(%q<cocoapods-plugins>.freeze, ["< 2.0", ">= 1.0.0"])
      s.add_dependency(%q<cocoapods-search>.freeze, ["< 2.0", ">= 1.0.0"])
      s.add_dependency(%q<cocoapods-stats>.freeze, ["< 2.0", ">= 1.0.0"])
      s.add_dependency(%q<cocoapods-trunk>.freeze, ["< 2.0", ">= 1.3.1"])
      s.add_dependency(%q<cocoapods-try>.freeze, ["< 2.0", ">= 1.1.0"])
      s.add_dependency(%q<molinillo>.freeze, ["~> 0.6.6"])
      s.add_dependency(%q<xcodeproj>.freeze, ["< 2.0", ">= 1.8.1"])
      s.add_dependency(%q<activesupport>.freeze, ["< 5", ">= 4.0.2"])
      s.add_dependency(%q<colored2>.freeze, ["~> 3.1"])
      s.add_dependency(%q<escape>.freeze, ["~> 0.0.4"])
      s.add_dependency(%q<fourflusher>.freeze, ["< 3.0", ">= 2.2.0"])
      s.add_dependency(%q<gh_inspector>.freeze, ["~> 1.0"])
      s.add_dependency(%q<nap>.freeze, ["~> 1.0"])
      s.add_dependency(%q<ruby-macho>.freeze, ["~> 1.4"])
      s.add_dependency(%q<bacon>.freeze, ["~> 1.1"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    end
  else
    s.add_dependency(%q<cocoapods-core>.freeze, ["= 1.6.1"])
    s.add_dependency(%q<claide>.freeze, ["< 2.0", ">= 1.0.2"])
    s.add_dependency(%q<cocoapods-deintegrate>.freeze, ["< 2.0", ">= 1.0.2"])
    s.add_dependency(%q<cocoapods-downloader>.freeze, ["< 2.0", ">= 1.2.2"])
    s.add_dependency(%q<cocoapods-plugins>.freeze, ["< 2.0", ">= 1.0.0"])
    s.add_dependency(%q<cocoapods-search>.freeze, ["< 2.0", ">= 1.0.0"])
    s.add_dependency(%q<cocoapods-stats>.freeze, ["< 2.0", ">= 1.0.0"])
    s.add_dependency(%q<cocoapods-trunk>.freeze, ["< 2.0", ">= 1.3.1"])
    s.add_dependency(%q<cocoapods-try>.freeze, ["< 2.0", ">= 1.1.0"])
    s.add_dependency(%q<molinillo>.freeze, ["~> 0.6.6"])
    s.add_dependency(%q<xcodeproj>.freeze, ["< 2.0", ">= 1.8.1"])
    s.add_dependency(%q<activesupport>.freeze, ["< 5", ">= 4.0.2"])
    s.add_dependency(%q<colored2>.freeze, ["~> 3.1"])
    s.add_dependency(%q<escape>.freeze, ["~> 0.0.4"])
    s.add_dependency(%q<fourflusher>.freeze, ["< 3.0", ">= 2.2.0"])
    s.add_dependency(%q<gh_inspector>.freeze, ["~> 1.0"])
    s.add_dependency(%q<nap>.freeze, ["~> 1.0"])
    s.add_dependency(%q<ruby-macho>.freeze, ["~> 1.4"])
    s.add_dependency(%q<bacon>.freeze, ["~> 1.1"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
  end
end
