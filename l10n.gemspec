$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require 'l10n/version'

Gem::Specification.new do |s|
  s.name          = 'l10n'
  s.version       = L10n::VERSION
  s.date          = '2026-02-05'
  s.description   = 'Extensions for Rails I18n'
  s.summary       = 'Make I18n roar again'
  s.authors       = ['Matthias Grosser']
  s.email         = 'mtgrosser@gmx.net'
  s.require_path  = 'lib'
  s.files         = Dir['{lib}/**/*.{rb,yml,rake,js}', 'LICENSE', 'README.md', 'CHANGELOG.md']
  s.homepage      = 'https://github.com/mtgrosser/l10n'
  s.licenses      = ['MIT']

  s.required_ruby_version = '>= 3.2'
  
  s.add_dependency 'i18n'
  s.add_dependency 'activerecord', '>= 7.0.0', '~> 8.1.0'
  s.add_dependency 'activesupport', '>= 7.0.0', '~> 8.1.0'
  s.add_dependency 'actionpack', '>= 7.0.0', '~> 8.1.0'
  s.add_dependency 'railties', '>= 7.0.0', '~> 8.1.0'
end
