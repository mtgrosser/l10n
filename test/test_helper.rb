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

BigDecimal.class_eval do
  def inspect
    "#<BigDecimal:#{object_id.to_s(0x10)}@#{precs.first},#{precs.last}  #{to_s}>"
  end
end

class ActiveSupport::TestCase

  private
  
  def assert_equal(exp, act, msg = nil)
    msg = message(msg) {
      exp_str = mu_pp(exp)
      act_str = mu_pp(act)
      exp_comment = ''
      act_comment = ''
      if exp_str == act_str
        if (exp.is_a?(String) && act.is_a?(String)) ||
           (exp.is_a?(Regexp) && act.is_a?(Regexp))
          exp_comment = " (#{exp.encoding})"
          act_comment = " (#{act.encoding})"
        elsif exp.is_a?(Float) && act.is_a?(Float)
          exp_str = "%\#.#{Float::DIG+2}g" % exp
          act_str = "%\#.#{Float::DIG+2}g" % act
        elsif exp.is_a?(Time) && act.is_a?(Time)
          if exp.subsec * 1000_000_000 == exp.nsec
            exp_comment = " (#{exp.nsec}[ns])"
          else
            exp_comment = " (subsec=#{exp.subsec})"
          end
          if act.subsec * 1000_000_000 == act.nsec
            act_comment = " (#{act.nsec}[ns])"
          else
            act_comment = " (subsec=#{act.subsec})"
          end
        elsif exp.class != act.class
          # a subclass of Range, for example.
          exp_comment = " (#{exp.class})"
          act_comment = " (#{act.class})"
        end
      elsif !Encoding.compatible?(exp_str, act_str)
        if exp.is_a?(String) && act.is_a?(String)
          exp_str = exp.dump
          act_str = act.dump
          exp_comment = " (#{exp.encoding})"
          act_comment = " (#{act.encoding})"
        else
          exp_str = exp_str.dump
          act_str = act_str.dump
        end
      end
      "<#{exp_str}>#{exp_comment} expected but was\n<#{act_str}>#{act_comment}"
    }
    assert(exp == act, msg)
  end
  
  def assert_include(array_or_string, object, message = nil)
    fail "object expected, got nil" if array_or_string.nil?
    assert array_or_string.include?(object), message || "Expected #{array_or_string} to include #{object}, but didn't"
  end
    
end
