module L10n
  module CoreExtensions
    module DateExt
      def localize(*args)
        I18n.l(self, *args)
      end
      alias :l :localize
    end
  end
end

Date.send :include, L10n::CoreExtensions::DateExt