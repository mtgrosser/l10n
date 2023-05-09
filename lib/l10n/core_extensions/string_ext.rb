module L10n
  module CoreExtensions
    module StringExt
      def translate(*args, **kwargs, &block)
        I18n.t(self, *args, **kwargs, &block)
      end
      alias :t :translate
    end
  end
end

String.include L10n::CoreExtensions::StringExt
