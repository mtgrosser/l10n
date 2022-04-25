require 'i18n'
require 'date'
require 'bigdecimal'
require 'action_view'
require 'action_dispatch'
require 'active_support/all'

require_relative 'l10n/version'
require_relative 'l10n/core_extensions/object_ext'
require_relative 'l10n/core_extensions/string_ext'
require_relative 'l10n/core_extensions/symbol_ext'
require_relative 'l10n/core_extensions/date_time_ext'
require_relative 'l10n/core_extensions/numeric_ext'
require_relative 'l10n/i18n_extensions'
require_relative 'l10n/inflections'
require_relative 'l10n/numeric_column_conversions'
require_relative 'l10n/column_translation'
require_relative 'l10n/translation_validator'
require_relative 'l10n/forms'
require_relative 'l10n/request'
require_relative 'l10n/engine'

files = Dir[File.join(File.dirname(__FILE__), 'locales/*.yml')]
I18n.load_path.concat(files)

module L10n
  
  class << self
    
    #def default?
    #  language_code == default_language_code
    #end
    
    #def language_code
    #  normalize_language_code(locale) if locale
    #end
    
    #def default_language_code
    #  normalize_language_code(default_locale) if default_locale
    #end
    
    #def avaliable_locales
    #  
    #end
    
    #def available_language_codes
    #  i18n_available_locales.map { |i18n_locale| normalize_language_code(i18n_locale) }.uniq
    #end
    
    def number_to_rounded(number, options = {})
      ActiveSupport::NumberHelper.number_to_rounded(number, options)
    end
        
    private
    
    #def normalize_language_code(code)
    #  code.to_s[0..1].downcase
    #end
    
    #def i18n_available_locales
    #  I18n.available_locales
    #end
    
    #def i18n_current_language
    #  
    #end
      
  end
  
  
end
