# -*- encoding: utf-8 -*-
# stub: active_shipping 0.11.0 ruby lib

Gem::Specification.new do |s|
  s.name = "active_shipping"
  s.version = "0.11.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["James MacAulay", "Tobi Lutke", "Cody Fauser", "Jimmy Baker"]
  s.date = "2013-09-15"
  s.description = "Get rates and tracking info from various shipping carriers."
  s.email = ["james@shopify.com"]
  s.homepage = "http://github.com/shopify/active_shipping"
  s.require_paths = ["lib"]
  s.rubyforge_project = "active_shipping"
  s.rubygems_version = "2.1.5"
  s.summary = "Shipping API extension for Active Merchant"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.3.5"])
      s.add_runtime_dependency(%q<i18n>, [">= 0"])
      s.add_runtime_dependency(%q<active_utils>, [">= 1.0.1"])
      s.add_runtime_dependency(%q<builder>, [">= 0"])
      s.add_runtime_dependency(%q<json>, [">= 1.5.1"])
      s.add_development_dependency(%q<minitest>, ["~> 4.7.5"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<mocha>, ["~> 0.14.0"])
      s.add_development_dependency(%q<timecop>, [">= 0"])
      s.add_development_dependency(%q<nokogiri>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.3.5"])
      s.add_dependency(%q<i18n>, [">= 0"])
      s.add_dependency(%q<active_utils>, [">= 1.0.1"])
      s.add_dependency(%q<builder>, [">= 0"])
      s.add_dependency(%q<json>, [">= 1.5.1"])
      s.add_dependency(%q<minitest>, ["~> 4.7.5"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<mocha>, ["~> 0.14.0"])
      s.add_dependency(%q<timecop>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.3.5"])
    s.add_dependency(%q<i18n>, [">= 0"])
    s.add_dependency(%q<active_utils>, [">= 1.0.1"])
    s.add_dependency(%q<builder>, [">= 0"])
    s.add_dependency(%q<json>, [">= 1.5.1"])
    s.add_dependency(%q<minitest>, ["~> 4.7.5"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<mocha>, ["~> 0.14.0"])
    s.add_dependency(%q<timecop>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
  end
end
