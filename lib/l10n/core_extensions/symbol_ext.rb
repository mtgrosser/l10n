module L10n
  module CoreExtensions
    module SymbolExt
      def translate(*args, **kwargs, &block)
        I18n.t(self, *args, **kwargs, &block)
      end
      alias :t :translate
    end
  end
end

Symbol.include L10n::CoreExtensions::SymbolExt
