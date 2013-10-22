# -*- encoding: utf-8 -*-
# stub: savon 2.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "savon"
  s.version = "2.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Harrington"]
  s.date = "2013-04-21"
  s.description = "Heavy metal SOAP client"
  s.email = "me@rubiii.com"
  s.homepage = "http://savonrb.com"
  s.require_paths = ["lib"]
  s.rubyforge_project = "savon"
  s.rubygems_version = "2.1.5"
  s.summary = "Heavy metal SOAP client"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nori>, ["~> 2.1.0"])
      s.add_runtime_dependency(%q<httpi>, ["~> 2.0.2"])
      s.add_runtime_dependency(%q<wasabi>, ["~> 3.1.0"])
      s.add_runtime_dependency(%q<akami>, ["~> 1.2.0"])
      s.add_runtime_dependency(%q<gyoku>, ["~> 1.0.0"])
      s.add_runtime_dependency(%q<builder>, [">= 2.1.2"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 1.4.0"])
      s.add_development_dependency(%q<rack>, [">= 0"])
      s.add_development_dependency(%q<puma>, ["= 2.0.0.b4"])
      s.add_development_dependency(%q<rake>, ["~> 0.9"])
      s.add_development_dependency(%q<rspec>, ["~> 2.10"])
      s.add_development_dependency(%q<mocha>, ["~> 0.11"])
      s.add_development_dependency(%q<json>, ["~> 1.7"])
    else
      s.add_dependency(%q<nori>, ["~> 2.1.0"])
      s.add_dependency(%q<httpi>, ["~> 2.0.2"])
      s.add_dependency(%q<wasabi>, ["~> 3.1.0"])
      s.add_dependency(%q<akami>, ["~> 1.2.0"])
      s.add_dependency(%q<gyoku>, ["~> 1.0.0"])
      s.add_dependency(%q<builder>, [">= 2.1.2"])
      s.add_dependency(%q<nokogiri>, [">= 1.4.0"])
      s.add_dependency(%q<rack>, [">= 0"])
      s.add_dependency(%q<puma>, ["= 2.0.0.b4"])
      s.add_dependency(%q<rake>, ["~> 0.9"])
      s.add_dependency(%q<rspec>, ["~> 2.10"])
      s.add_dependency(%q<mocha>, ["~> 0.11"])
      s.add_dependency(%q<json>, ["~> 1.7"])
    end
  else
    s.add_dependency(%q<nori>, ["~> 2.1.0"])
    s.add_dependency(%q<httpi>, ["~> 2.0.2"])
    s.add_dependency(%q<wasabi>, ["~> 3.1.0"])
    s.add_dependency(%q<akami>, ["~> 1.2.0"])
    s.add_dependency(%q<gyoku>, ["~> 1.0.0"])
    s.add_dependency(%q<builder>, [">= 2.1.2"])
    s.add_dependency(%q<nokogiri>, [">= 1.4.0"])
    s.add_dependency(%q<rack>, [">= 0"])
    s.add_dependency(%q<puma>, ["= 2.0.0.b4"])
    s.add_dependency(%q<rake>, ["~> 0.9"])
    s.add_dependency(%q<rspec>, ["~> 2.10"])
    s.add_dependency(%q<mocha>, ["~> 0.11"])
    s.add_dependency(%q<json>, ["~> 1.7"])
  end
end
