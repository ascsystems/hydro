# -*- encoding: utf-8 -*-
# stub: actionview-encoded_mail_to 1.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "actionview-encoded_mail_to"
  s.version = "1.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nick Reed"]
  s.date = "2013-06-21"
  s.description = "Rails mail_to helper with encoding (removed from core in Rails 4.0)"
  s.email = "reednj77@gmail.com"
  s.homepage = "https://github.com/reed/actionview-encoded_mail_to"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.5"
  s.summary = "Deprecated support for email address obfuscation within the mail_to helper method."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 0"])
  end
end
