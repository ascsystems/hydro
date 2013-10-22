# -*- encoding: utf-8 -*-
# stub: rails-perftest 0.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "rails-perftest"
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Yves Senn"]
  s.date = "2013-07-25"
  s.description = "Rails performance tests (removed from core in Rails 4.0)"
  s.email = ["yves.senn@gmail.com"]
  s.executables = ["perftest"]
  s.files = ["bin/perftest"]
  s.homepage = "https://github.com/rails/rails-perftest"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.5"
  s.summary = "ActionDispatch::PerformanceTest, ActiveSupport::Testing::Performance extracted from Rails."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<ruby-prof>, [">= 0.12.1"])
      s.add_development_dependency(%q<minitest>, [">= 3"])
      s.add_development_dependency(%q<railties>, ["~> 4.0"])
      s.add_development_dependency(%q<activerecord>, ["~> 4.0"])
      s.add_development_dependency(%q<activemodel>, ["~> 4.0"])
      s.add_development_dependency(%q<actionmailer>, ["~> 4.0"])
      s.add_development_dependency(%q<actionpack>, ["~> 4.0"])
      s.add_development_dependency(%q<sqlite3>, ["~> 1.3"])
    else
      s.add_dependency(%q<ruby-prof>, [">= 0.12.1"])
      s.add_dependency(%q<minitest>, [">= 3"])
      s.add_dependency(%q<railties>, ["~> 4.0"])
      s.add_dependency(%q<activerecord>, ["~> 4.0"])
      s.add_dependency(%q<activemodel>, ["~> 4.0"])
      s.add_dependency(%q<actionmailer>, ["~> 4.0"])
      s.add_dependency(%q<actionpack>, ["~> 4.0"])
      s.add_dependency(%q<sqlite3>, ["~> 1.3"])
    end
  else
    s.add_dependency(%q<ruby-prof>, [">= 0.12.1"])
    s.add_dependency(%q<minitest>, [">= 3"])
    s.add_dependency(%q<railties>, ["~> 4.0"])
    s.add_dependency(%q<activerecord>, ["~> 4.0"])
    s.add_dependency(%q<activemodel>, ["~> 4.0"])
    s.add_dependency(%q<actionmailer>, ["~> 4.0"])
    s.add_dependency(%q<actionpack>, ["~> 4.0"])
    s.add_dependency(%q<sqlite3>, ["~> 1.3"])
  end
end
