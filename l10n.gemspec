$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require 'l10n/version'

Gem::Specification.new do |s|
  s.name          = 'l10n'
  s.version       = L10n::VERSION
  s.date          = '2022-04-24'
  s.description   = 'Extensions for Rails I18n'
  s.summary       = 'Make I18n roar again'
  s.authors       = ['Matthias Grosser']
  s.email         = 'mtgrosser@gmx.net'
  s.require_path  = 'lib'
  s.files         = Dir['{lib}/**/*.rb', '{lib}/**/*.yml', 'bin/*', 'app/**/*.*', 'MIT-LICENSE', 'README.md', 'CHANGELOG']
  s.homepage      = 'https://github.com/mtgrosser/l10n'
  s.licenses      = ['MIT']
  
  s.add_dependency 'i18n' #, '~> 0.5'
  s.add_runtime_dependency 'activerecord', '>= 7.0.0', '< 7.1'
  s.add_runtime_dependency 'activesupport', '>= 7.0.0', '< 7.1'
  s.add_runtime_dependency 'actionpack', '>= 7.0.0', '< 7.1'
  s.add_runtime_dependency 'railties', '>= 7.0.0', '< 7.1'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'byebug'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'rake', '>= 0.8.7'
end
