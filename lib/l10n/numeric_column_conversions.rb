module L10n
  module NumericColumnConversions

    def self.included(base)
      base.alias_method_chain :convert_number_column_value, :l10n
    end

    def convert_number_column_value_with_l10n(value)
      Numeric.delocalize(convert_number_column_value_without_l10n(value))
    end

  end

end

ActiveRecord::Base.class_eval { include L10n::NumericColumnConversions }
