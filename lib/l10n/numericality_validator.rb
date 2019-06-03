module L10n
  module NumericalityValidatorExt
    
    private

    def parse_as_number(raw_value)
      raw_value = Numeric.delocalize(raw_value) if is_localized_number?(raw_value)
      super(raw_value)
    end

    def is_localized_number?(value)
      numeric_exp_for_current_locale === value
    end
    
    def numeric_exp_for_current_locale
      separator = I18n.t(:'number.format.separator')
      delimiter = I18n.t(:'number.format.delimiter')
      @numeric_exp ||= {}
      @numeric_exp[[delimiter, separator]] ||= /\A[+-]?\d{1,3}(#{Regexp.escape(delimiter)}?\d\d\d)*(#{Regexp.escape(separator)}\d\d*)?\z/
    end
    
  end
end

ActiveModel::Validations::NumericalityValidator.prepend L10n::NumericalityValidatorExt
