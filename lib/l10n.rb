require 'i18n'
require 'action_view'
require 'action_dispatch'
require 'active_support'

require 'l10n/core_extensions'
require 'l10n/i18n_extensions'
require 'l10n/numeric_column_conversions'
require 'l10n/column_translation'
require 'l10n/forms'
require 'l10n/request'

module L10n
  @number_helper = Object.new.tap { |obj| obj.extend ActionView::Helpers::NumberHelper }
  
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
    
    def number_with_precision(number, options = {})
      #options.symbolize_keys!
      #defaults = { :separator => I18n.t('number.format.separator'),
      #             :delimiter => I18n.t('number.format.delimiter'),
      #             :precision => I18n.t('number.format.precision') }
      #options.reverse_merge!(defaults)
      @number_helper.number_with_precision(number, options)
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