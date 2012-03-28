require 'i18n'
require 'active_record'
require 'action_view'

require 'l10n/core_extensions'
require 'l10n/numeric_column_conversions'


module L10n
  @number_helper = Object.new.tap { |obj| obj.extend ActionView::Helpers::NumberHelper }
  
  class << self
    
    def default?
      language_code == default_language_code
    end
    
    def language_code
      normalize_language_code(locale) if locale
    end
    
    def default_language_code
      normalize_language_code(default_locale) if default_locale
    end
    
    #def avaliable_locales
    #  
    #end
    
    def available_language_codes
      i18n_available_locales.map { |i18n_locale| normalize_language_code(i18n_locale) }.uniq
    end
    

    # TODO: remove, deprecated
    # def localize(value, options = {})
    #  case value
    #  when Numeric then @number_helper.number_with_precision(value, options)
    #  end
    #end
    #alias :l :localize
    
    def number_with_precision(*args)
      @number_helper.number_with_precision(*args)
    end
    
    private
    
    def normalize_language_code(code)
      code.to_s[0..1].downcase
    end
    
    def i18n_available_locales
      I18n.available_locales
    end
    
    def i18n_current_language
      
    end
      
  end
  
  
end