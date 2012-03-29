# Project-specific configuration for CruiseControl.rb

Project.configure do |project|
  project.build_command = 'rbfu @1.9.3 rake'
  project.scheduler.polling_interval = 30.minutes
  # Set any args for bundler here
  # Defaults to '--path=#{project.gem_install_path} --gemfile=#{project.gemfile} --no-color'
  #project.bundler_args = "--path=#{project.gem_install_path} --gemfile=#{project.gemfile} --no-color --local"
end