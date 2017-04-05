require 'active_record'

module L10n
  module NumericColumnConversions

    private
  
    def write_attribute(attr_name, value)
      column = column_for_attribute(attr_name.to_s)
      if column && [:integer, :float, :decimal].include?(column.type) && value.is_a?(String)
        value = Numeric.delocalize(value)
      end
      super(attr_name, value)
    end
  
  end
  
end

ActiveRecord::Base.prepend L10n::NumericColumnConversions
