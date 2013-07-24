module L10n
  module Inflections
  
    def ordinalize(number)
      "#{number}#{ordinal(number)}"
    end
    
    def ordinal(number)
      abs_number = number.to_i.abs

      key = if (11..13).include?(abs_number % 100)
        :other
      else
        case abs_number % 10
          when 1; :first
          when 2; :second
          when 3; :third
          else    :other
        end
      end
      I18n.t("i18n.inflections.ordinals.#{key}")
    end
    
  end
end

ActiveSupport::Inflector.extend L10n::Inflections
ActiveSupport::Inflector.send :include, L10n::Inflections
