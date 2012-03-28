Gem::Specification.new do |s|
  s.name          = 'l10n'
  s.version       = File.read(File.join(File.dirname(__FILE__), 'VERSION')).strip
  s.date          = '2012-03-28'
  s.summary       = "Extensions for Rails I18n"
  s.description   = "Extensions for Rails I18n"
  s.authors       = ['Matthias Grosser']
  s.email         = 'mtgrosser@gmx.net'
  s.require_path  = 'lib'
  s.files         = Dir['{lib}/**/*.rb', 'bin/*', 'MIT-LICENSE', 'VERSION', 'README.md', 'CHANGELOG']
  s.homepage      = 'http://rubygems.org/gems/l10n'
  
  s.add_dependency 'i18n', '~> 0.5'
  s.add_dependency 'rails', '>= 3.0.0'
end
