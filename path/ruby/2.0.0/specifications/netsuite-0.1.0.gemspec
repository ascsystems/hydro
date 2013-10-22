# -*- encoding: utf-8 -*-
# stub: netsuite 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "netsuite"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Moran", "Michael Bianco"]
  s.date = "2013-04-30"
  s.description = "NetSuite SuiteTalk API Wrapper"
  s.email = ["ryan.moran@gmail.com", "info@cliffsidedev.com"]
  s.homepage = "https://github.com/RevolutionPrep/netsuite"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.5"
  s.summary = "NetSuite SuiteTalk API Wrapper"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<savon>, ["~> 2.2.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.10"])
    else
      s.add_dependency(%q<savon>, ["~> 2.2.0"])
      s.add_dependency(%q<rspec>, ["~> 2.10"])
    end
  else
    s.add_dependency(%q<savon>, ["~> 2.2.0"])
    s.add_dependency(%q<rspec>, ["~> 2.10"])
  end
end
