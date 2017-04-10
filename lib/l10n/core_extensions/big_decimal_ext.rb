module L10n
  module CoreExtensions
    module BigDecimalExt

      def to_localized_s
        Numeric.localize(self)
      end

      def to_formatted_s(*args)
        L10n.number_to_rounded(self, *args)
      end

    end
  end
end

BigDecimal.prepend L10n::CoreExtensions::BigDecimalExt
