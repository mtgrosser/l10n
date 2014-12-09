$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require 'l10n/version'

Gem::Specification.new do |s|
  s.name          = 'l10n'
  s.version       = L10n::VERSION
  s.date          = '2014-08-12'
  s.summary       = "Extensions for Rails I18n"
  s.description   = "I18n that roarrrs"
  s.authors       = ['Matthias Grosser']
  s.email         = 'mtgrosser@gmx.net'
  s.require_path  = 'lib'
  s.files         = Dir['{lib}/**/*.rb', '{lib}/**/*.yml', 'bin/*', 'MIT-LICENSE', 'VERSION', 'README.md', 'CHANGELOG', 'Rakefile']
  s.homepage      = 'http://rubygems.org/gems/l10n'
  
  s.add_dependency 'i18n' #, '~> 0.5'
  s.add_dependency 'activerecord', '~> 4.0'
  s.add_dependency 'activesupport', '~> 4.0'
  s.add_dependency 'actionpack', '~> 4.0'
  s.add_dependency 'railties', '~> 4.0'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'byebug'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'rake', '>= 0.8.7'
end
