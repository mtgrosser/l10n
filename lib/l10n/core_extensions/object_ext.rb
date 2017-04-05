module L10n
  module CoreExtensions
    module ObjectExt
      def to_localized_s
        to_s
      end
    end 
  end
end

Object.send :include, L10n::CoreExtensions::ObjectExt
