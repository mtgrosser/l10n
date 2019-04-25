require_relative '../test_helper'

class NumericalityValidatorTest < ActiveSupport::TestCase
  
  test 'Validation of numericality on ActiveRecord instances' do
    I18n.as 'en' do
      airplane = Airplane.new(wingspan: '68,000.4')
      assert_equal BigDecimal('68000.4'), airplane.wingspan
      assert airplane.valid?
      airplane = Airplane.new(wingspan: '68.000,4')
      assert airplane.valid?
      assert_equal 68, airplane.wingspan
    end
    I18n.as 'de' do
      airplane = Airplane.new(wingspan: '68.000,4')
      assert_equal BigDecimal('68000.4'), airplane.wingspan
      assert airplane.valid?
      airplane = Airplane.new(wingspan: '68,000.4')
      assert airplane.valid?
      assert_equal 68, airplane.wingspan
    end
  end
  
  test 'Validation of numericality on ActiveModel instances which provide attributes before type cast' do
    skip 'Cannot access value before cast due to numeric column conversion'
    I18n.as 'en' do
      model_airplane = ModelAirplane.new
      model_airplane.wingspan_before_type_cast = '1,800.4'
      model_airplane.wingspan = 1_800.4
      assert model_airplane.valid?
      
      model_airplane.wingspan_before_type_cast = '1.800,4'

      model_airplane.wingspan = 1.8
      assert_equal false, model_airplane.valid?
    end
    I18n.as 'de' do
      model_airplane = ModelAirplane.new
      model_airplane.wingspan_before_type_cast = '1.800,4'
      model_airplane.wingspan = 1_800.4
      assert model_airplane.valid?
      
      model_airplane.wingspan_before_type_cast = '1,800.4'
      model_airplane.wingspan = 1.8
      assert_equal false, model_airplane.valid?
    end
  end

end
