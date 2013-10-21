require File.expand_path('../../test_helper', __FILE__)

class TranslationValidatorTest < ActiveSupport::TestCase
  
  test 'Translation validations' do
    truck = Truck.new(:model => 'MAN')
    assert_equal false, truck.valid?
    truck.model_de = 'MAN'
    assert_equal true, truck.valid?
    truck.model = nil
    assert_equal false, truck.valid?
  end
  
end