require 'rails/engine'

class L10n::Railtie < Rails::Railtie
  initializer 'l10n' do |app|
    
  end
  
  rake_tasks do
    load Pathname.new(__FILE__).dirname.join('..', 'tasks', 'l10n.rake')
  end
end
