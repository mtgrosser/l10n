module L10n
  module CoreExtensions
    module BigDecimalExt
      extend ActiveSupport::Concern
      
      included do
        alias_method :_active_support_to_formatted_s, :to_formatted_s
        alias_method :to_s, :_active_support_to_formatted_s
        alias_method :to_formatted_s, :_l10n_to_formatted_s
      end
      
      def _l10n_to_formatted_s(*args)
        L10n.number_to_rounded(self, *args)
      end
      #
    end
  end
end

BigDecimal.class_eval { include L10n::CoreExtensions::BigDecimalExt }
