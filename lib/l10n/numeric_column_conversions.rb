require 'active_record'

module L10n
  module NumericColumnConversions

    private
  
    def write_attribute(attr, value)
      value = Numeric.delocalize(value) if value.is_a?(String)
      super(attr, value)
    end
  
  end
  
end

ActiveRecord::Base.class_eval { include L10n::NumericColumnConversions }
