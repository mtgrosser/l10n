module L10n
  module I18nExtensions
   
    def self.included(base)
      base.extend ClassMethods
      base.mattr_accessor :preferred_locale
    end
   
    module ClassMethods
     
      def default?
        language_code == default_language_code
      end
      
      def language_code
        normalize_language_code(locale) if locale
      end
      
      ## deprecated
      #def country_code
      #  if locale.to_s.match(/\w\w-\w\w/)
      #    locale.to_s[-2..-1]
      #  else
      #    normalize_locale_code(locale)[-2..-1]
      #  end
      #end
     
      def default_language_code
        normalize_language_code(default_locale) if default_locale
      end
     
      def available_language_codes
        available_locales.map { |locale| normalize_language_code(locale) }.uniq
      end
      
      def translation_language_codes
        I18n.available_language_codes - [I18n.default_language_code]
      end
      
      def available(locale)
        return nil if locale.blank?
        locale = normalize_locale_code(locale)
        available_locales.include?(locale) ? locale : nil
      end
    
      def available?(locale)
        available(locale) ? true : false
      end
     
      def as(tmp_locale)
        if normalized_code = normalize_locale_code(tmp_locale)
          previous_locale = self.locale
          self.locale = normalized_code
        end
        yield
      ensure
        self.locale = previous_locale if normalized_code
      end
      
      def as_default
        I18n.as(I18n.default_locale) { yield }
      end
      
      def as_each
        available_language_codes.inject({}) { |hash, code| hash[code] = I18n.as(code) { yield(code) }; hash }
      end
      
      def translations(key)
        available_language_codes.inject({}) { |hash, code| hash[code] = I18n.as(code) { I18n.t(key) }; hash }
      end
      
      def translation_suffix
        default? ? '' : "_#{I18n.language_code}"
      end
     
      private
      
      # ISO 639-1 two-letter language code 
      def normalize_language_code(code)
        code.to_s[0..1].downcase.to_sym
      end
      
      # deprecated
      def normalize_locale_code(code)
        normalize_language_code(code)
      end
      
    end
    
  end
end

I18n.send :include, L10n::I18nExtensions