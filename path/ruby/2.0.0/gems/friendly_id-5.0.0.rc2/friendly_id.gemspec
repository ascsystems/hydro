# encoding: utf-8
require File.expand_path("../lib/friendly_id/version", __FILE__)

Gem::Specification.new do |s|
  s.name              = "friendly_id"
  s.version           = FriendlyId::VERSION
  s.authors           = ["Norman Clarke", "Philip Arndt"]
  s.email             = ["norman@njclarke.com", "p@arndt.io"]
  s.homepage          = "http://github.com/norman/friendly_id"
  s.summary           = "A comprehensive slugging and pretty-URL plugin."
  s.rubyforge_project = "friendly_id"
  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- {test}/*`.split("\n")
  s.require_paths     = ["lib"]
  s.license           = 'MIT'

  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency 'activerecord', '~> 4.0.0'

  s.add_development_dependency 'railties', '~> 4.0.0'
  s.add_development_dependency 'minitest', '>= 4.4.0'
  s.add_development_dependency 'mocha', '~> 0.13.3'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'i18n'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'redcarpet'

  s.description = <<-EOM
FriendlyId is the "Swiss Army bulldozer" of slugging and permalink plugins for
Active Record. It lets you create pretty URLs and work with human-friendly
strings as if they were numeric ids.
EOM
end