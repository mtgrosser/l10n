module L10n
  module CoreExtensions
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
      
      def to_formatted_s(*args)
        L10n.number_with_precision(self, *args)
      end
      
    end
  end
end

Numeric.send :include, L10n::CoreExtensions::NumericExt
