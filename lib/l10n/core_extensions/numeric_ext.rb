module L10n
  module CoreExtensions
    module NumericExt
      extend ActiveSupport::Concern
      
      included do
        alias_method :_active_support_to_formatted_s, :to_formatted_s
        alias_method :to_formatted_s, :_l10n_to_formatted_s
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
      
      # Provide l10n signature
      def _l10n_to_formatted_s(format = :rounded, options = nil)
        if options.nil? && format.is_a?(Hash)
          options = format
          format = :rounded
        end
        _active_support_to_formatted_s(format, options || {})
      end
      
    end
  end
end

Numeric.class_eval { include L10n::CoreExtensions::NumericExt }
