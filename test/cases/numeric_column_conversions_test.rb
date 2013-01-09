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
  
  test 'Changing a decimal value from integer to fractional is respected by Dirty' do
    
    { 'en' => '.', 'de' => ',' }.each do |locale, separator|
      I18n.as locale do
        car = Car.create!(:price => "6#{separator}00", :speed => "123#{separator}5", :make_t => 'VW', :model_t => 'Golf')
        assert_equal 6, car.price
        assert_equal 123.5, car.speed
        car.price = "6#{separator}50"
        car.speed = "123#{separator}0"
        assert_equal 6.5, car.price
        assert_equal 123, car.speed
        car.save!
        assert_equal 6.5, car.price
        assert_equal 123, car.speed
        car.reload
        assert_equal 6.5, car.price
        assert_equal 123, car.speed
      end
    end
  end
  
end