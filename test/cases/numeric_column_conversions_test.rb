require File.expand_path('../../test_helper', __FILE__)

class NumericColumnConversionsTest < ActiveSupport::TestCase
  
  test 'Fractional numbers are properly set respecting the current locale decimal separator' do
    I18n.as 'en' do
      car = Car.new(:price => "1,029.5", :speed => "1.029,5")
      assert_equal 1029.5, car.price
      assert_equal 1.0295, car.speed
    end
    I18n.as 'de' do
      car = Car.new(:price => "1.029,5", :speed => "1,029.5")
      assert_equal 1029.5, car.price
      assert_equal 1.0295, car.speed
    end
  end
  
end