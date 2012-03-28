module L10n
  module CoreExtensions
    
    module ObjectExt
      def to_localized_s
        to_s
      end
    end

    module StringExt
      def translate(*args)
        I18n.t(self, *args)
      end
      alias :t :translate
    end
    
    module SymbolExt
      def translate(*args)
        to_s.translate(*args)
      end
      alias :t :translate
    end

    module DateExt
      def localize(*args)
        I18n.l(self, *args)
      end
      alias :l :localize
    end
    
    module NumericExt

      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def delocalize(value)
          return value unless value.is_a?(String)
          separator = I18n.t(:'number.format.separator')
          delimiter = I18n.t(:'number.format.delimiter')
          value.gsub(delimiter, '').gsub(separator, '.')
        end
        
        def localize(value)
          return value unless value.is_a?(Numeric) or value.is_a?(String)
          separator = I18n.t(:'number.format.separator')
          delimiter = I18n.t(:'number.format.delimiter')
          value.to_s.gsub('.', 's').gsub(',', delimiter).gsub('s', separator)
        end
      end       

      def to_localized_s
        Numeric.localize(self)
      end
      
      def to_formatted_s
        L10n.number_with_precision(self)
      end
    end
    
    module BigDecimalExt
      def to_formatted_s
        L10n.number_with_precision(self)
      end
    end
    
  end
end

L10n::CoreExtensions.constants.each do |mod|
  extension = L10n::CoreExtensions.const_get(mod)
  klass = mod.to_s.sub(/Ext\z/, '').constantize
  klass.class_eval { include extension }
end

#Object.class_eval { include Localite::CoreExtensions::ObjectExt }
#String.class_ :include, Localite::CoreExtensions::StringExt
#Symbol.send :include, Localite::CoreExtensions::SymbolExt
#Numeric.send :include, Localite::CoreExtensions::NumericExt
#BigDecimal.send :include, Localite::CoreExtensions::BigDecimalExt
#Date.send :include, Localite::CoreExtensions::DateExt
