module L10n
  module CoreExtensions
    module SymbolExt
      def translate(*args)
        I18n.t(self, *args)
      end
      alias :t :translate
    end
  end
end

Symbol.send :include, L10n::CoreExtensions::SymbolExt