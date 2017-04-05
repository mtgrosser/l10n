module L10n
  module NumericalityValidatorExt
    
    protected
    
    def parse_raw_value_as_a_number(raw_value)
      separator = I18n.t(:'number.format.separator')
      puts "raw_value BEFORE: #{raw_value.inspect} "
      raw_value = Numeric.delocalize(raw_value) if raw_value.is_a?(String)
      puts "raw_value DELOC: #{raw_value.inspect} "
      puts
      
      Kernel.Float(raw_value) if raw_value !~ /\A0[xX]/
    end
  end
end

ActiveModel::Validations::NumericalityValidator.prepend L10n::NumericalityValidatorExt
