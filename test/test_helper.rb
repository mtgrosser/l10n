ENV["RAILS_ENV"] = "test"

require 'pathname'

if RUBY_VERSION >= '1.9'
  require 'simplecov'
  SimpleCov.start do
    if artifacts_dir = ENV['CC_BUILD_ARTIFACTS']
      coverage_dir Pathname.new(artifacts_dir).relative_path_from(Pathname.new(SimpleCov.root)).to_s
    end
    add_filter '/test/'
    add_filter 'vendor'
  end

  SimpleCov.at_exit do
    SimpleCov.result.format!
    if result = SimpleCov.result
      File.open(File.join(SimpleCov.coverage_path, 'coverage_percent.txt'), 'w') { |f| f << result.covered_percent.to_s }
    end
  end
end

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require 'minitest/autorun'

require 'l10n'

require 'byebug'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')

require File.expand_path('../schema', __FILE__)

Pathname.glob(Pathname.new(__FILE__).dirname.join('models').join('*.rb')).each { |model| require model.to_s.sub(/\.rb\z/, '') }

I18n.enforce_available_locales = true
I18n.load_path += Pathname.glob(Pathname.new(__FILE__).dirname.join('locales').join('*.yml'))
I18n.reload!

class ActiveSupport::TestCase

  private
  
  def assert_include(array_or_string, object, message = nil)
    fail "object expected, got nil" if array_or_string.nil?
    assert array_or_string.include?(object), message || "Expected #{array_or_string} to include #{object}, but didn't"
  end
    
end
