require_relative '../test_helper'

class FormBuilderTest < ActiveSupport::TestCase

  setup do
    @template = Object.new
    @template.extend ActionView::Helpers::FormHelper
    @template.extend ActionView::Helpers::FormOptionsHelper
  end
  
  test 'Amount field should respect format options' do
    car = Car.new(price: 1230.456)
    form_builder = ActionView::Helpers::FormBuilder.new(:car, car, @template, {})
    I18n.as :en do
      assert_include form_builder.amount_field(:price, precision: 0), '"1,230"'
      assert_include form_builder.amount_field(:price, precision: 1), '"1,230.5"'
      assert_include form_builder.amount_field(:price, precision: 2), '"1,230.46"'
    end
    I18n.as :de do
      assert_include form_builder.amount_field(:price, precision: 0), '"1.230"'
      assert_include form_builder.amount_field(:price, precision: 1), '"1.230,5"'
      assert_include form_builder.amount_field(:price, precision: 2), '"1.230,46"'
    end
  end
end