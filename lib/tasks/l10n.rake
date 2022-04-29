namespace :l10n do
  namespace :install do
    desc 'Copy the l10n.js file to assets'
    task :js do
      system "#{RbConfig.ruby} ./bin/rails app:template LOCATION=#{File.expand_path("../install/install.rb",  __dir__)}"
    end
  end
end
