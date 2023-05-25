require 'active_model'

module L10n
  module NumericColumnConversions

    def from_user(name, value, type, original_attribute = nil)
      if [:integer, :float, :decimal].include?(type.try(:type)) && value.is_a?(String)
        value = Numeric.delocalize(value)
      end
      super(name, value, type, original_attribute)
    end

  end

end

ActiveModel::Attribute.singleton_class.prepend L10n::NumericColumnConversions
