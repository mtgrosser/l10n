module L10n
  module CoreExtensions
    module StringExt
      def translate(*args)
        I18n.t(self, *args)
      end
      alias :t :translate
    end
  end
end

String.send :include, L10n::CoreExtensions::StringExt