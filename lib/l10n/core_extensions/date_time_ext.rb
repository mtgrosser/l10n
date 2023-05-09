module L10n
  module CoreExtensions
    module DateTimeExt
      def localize(*args, **kwargs)
        I18n.l(self, *args, **kwargs)
      end
      alias :l :localize
    end
  end
end

Date.include L10n::CoreExtensions::DateTimeExt
Time.include L10n::CoreExtensions::DateTimeExt
