require 'bigdecimal'

module L10n
  module CoreExtensions
    module BigDecimalExt
      
      def self.included(base)
        base.class_eval do
          alias_method :_active_support_to_formatted_s, :to_formatted_s
          alias_method :to_s, :_active_support_to_formatted_s
          alias_method :to_formatted_s, :_l10n_to_formatted_s
        end
      end
      
      def _l10n_to_formatted_s(*args)
        L10n.number_with_precision(self, *args)
      end
      #
    end
  end
end

BigDecimal.send :include, L10n::CoreExtensions::BigDecimalExt
