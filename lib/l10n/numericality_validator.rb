module L10n
  module NumericalityValidatorExt
    
    protected

    def parse_raw_value_as_a_number(raw_value)
      return if raw_value =~ /\A0[xX]/
      if raw_value.is_a?(String)
        return unless raw_value =~ numeric_exp_for_current_locale
        raw_value = Numeric.delocalize(raw_value)
      end
      Kernel.Float(raw_value)
    rescue ArgumentError, TypeError
      nil
    end
    
    private
    
    def numeric_exp_for_current_locale
      separator = I18n.t(:'number.format.separator')
      delimiter = I18n.t(:'number.format.delimiter')
      @numeric_exp ||= {}
      @numeric_exp[[delimiter, separator]] ||= /\A[+-]?\d{1,3}(#{Regexp.escape(delimiter)}?\d\d\d)*(#{Regexp.escape(separator)}\d\d*)?\z/
    end
    
  end
end

ActiveModel::Validations::NumericalityValidator.prepend L10n::NumericalityValidatorExt
