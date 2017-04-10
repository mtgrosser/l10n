module L10n
  module CoreExtensions
    module NumericExt
      
      module ClassMethods
        def delocalize(value)
          return value unless value.is_a?(String)
          separator = I18n.t(:'number.format.separator')
          delimiter = I18n.t(:'number.format.delimiter')
          value.gsub(delimiter, '').gsub(separator, '.')
        end
        
        def localize(value)
          return value unless value.is_a?(Numeric) || value.is_a?(String)
          separator = I18n.t(:'number.format.separator')
          delimiter = I18n.t(:'number.format.delimiter')
          value.to_s.gsub('.', 's').gsub(',', delimiter).gsub('s', separator)
        end
      end

      module Localization
        def to_localized_s
          Numeric.localize(self)
        end
      end
      
      module Formatting
        # un-deprecate method
        def to_formatted_s(format = :rounded, options = nil)
          if options.nil? && format.is_a?(Hash)
            options = format
            format = :rounded
          end
          to_s(format, options || {})
        end
      end
      
    end
  end
end

Numeric.extend L10n::CoreExtensions::NumericExt::ClassMethods

# Ruby 2.4+ unifies Fixnum & Bignum into Integer.
numerics = 0.class == Integer ? [Integer] : [Fixnum, Bignum]
numerics << Float
numerics << Rational

numerics.each do |klass|
  klass.include L10n::CoreExtensions::NumericExt::Localization
  klass.prepend L10n::CoreExtensions::NumericExt::Formatting
end
