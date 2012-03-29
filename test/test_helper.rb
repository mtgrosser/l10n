ENV["RAILS_ENV"] = "test"

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'test/unit'
require 'pathname'
require 'l10n'

require 'irb'

module IRB # :nodoc:
  def self.start_session(binding)
    unless @__initialized
      args = ARGV
      ARGV.replace(ARGV.dup)
      IRB.setup(nil)
      ARGV.replace(args)
      @__initialized = true
    end

    workspace = WorkSpace.new(binding)

    irb = Irb.new(workspace)

    @CONF[:IRB_RC].call(irb.context) if @CONF[:IRB_RC]
    @CONF[:MAIN_CONTEXT] = irb.context

    catch(:IRB_EXIT) do
      irb.eval_input
    end
  end
end

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')

require File.expand_path('../schema', __FILE__)

Pathname.glob(Pathname.new(__FILE__).dirname.join('models').join('*.rb')).each { |model| require model.to_s.sub(/\.rb\z/, '') }

I18n.load_path += Pathname.glob(Pathname.new(__FILE__).dirname.join('locales').join('*.yml'))
I18n.reload!

class ActiveSupport::TestCase
  
  
end