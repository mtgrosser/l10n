# encoding: utf-8

require File.expand_path('../../test_helper', __FILE__)

class ColumnTranslationTest < ActiveSupport::TestCase
  
  test 'Reading translated attributes' do
    car = Car.create!(:price => "1,029.5", :speed => "1.029,5",
                      :make => 'Vauxhall', :make_de => 'Opel', :model => 'Manta', :model_de => 'Mantra')
    I18n.as 'en' do
      assert_equal 'Vauxhall', car.make_t
      assert_equal 'Manta', car.model_t
    end
    I18n.as 'de' do
      assert_equal 'Opel', car.make_t
      assert_equal 'Mantra', car.model_t
    end
  end
  
  test 'Writing translated attributes' do
    car = Car.new
    I18n.as 'en' do
      assert car.update_attributes!(:make_t => 'Volkswagen', :model_t => 'Rabbit')
      assert_equal 'Volkswagen', car.reload.make
      assert_equal 'Rabbit', car.reload.model
    end
    I18n.as 'de' do
      assert_equal false, car.valid?
      assert car.update_attributes!(:make_t => 'VW', :model_t => 'Golf')
      assert_equal 'VW', car.make_t
      assert_equal 'Golf', car.model_t
      assert_equal 'Volkswagen', car.make
      assert_equal 'Rabbit', car.model
    end
  end
  
  test 'Default language attribute reader and writer are defined' do
    car = Car.create!(:make => 'Volkswagen', :make_de => 'VW', :model => 'Beetle', :model_de => 'Käfer')
    I18n.as_each do |code|
      assert_equal 'Volkswagen', car.reload.make_en
      assert_equal 'Beetle', car.model_en
      car.model_en = 'New Beetle'
      assert_equal 'New Beetle', car.model
    end
  end
  
  test 'Translations hash provides translations for all supported locales' do
    car = Car.create!(:make => 'Volkswagen', :make_de => 'VW', :model => 'Beetle', :model_de => 'Käfer')
    assert_equal({ :en => 'Volkswagen', :de => 'VW' }, car.make_translations)
    assert_equal({ :en => 'Beetle', :de => 'Käfer' }, car.model_translations)
  end
  
  test 'Translations hash setter' do
    car = Car.create!(:make_translations => { :de => 'Opel', :en => 'Vauxhall' }, :model_translations => { :all => 'Mantra' })
    assert_equal 'Opel', car.make_de
    assert_equal 'Vauxhall', car.make
    assert_equal 'Mantra', car.model
    assert_equal 'Mantra', car.model_de
  end
  
  test 'Default translation is used as fallback' do
    car = Car.create!(:make => 'Volkswagen', :model => 'Beetle', :model_de => 'Käfer')
    assert_equal 'Volkswagen', I18n.as(:en) { car.make_t }
    assert_nil I18n.as(:de) { car.make_t }
    assert_equal 'Volkswagen', I18n.as(:de) { car.make_t_with_fallback }
    assert_equal 'Volkswagen', I18n.as(:en) { car.make_t_with_fallback }
  end
  
  test 'Inheritance' do
    assert_equal true, Car.translates?('make')
    assert_equal true, Car.translates?(:model)
    assert_equal false, Car.translates?(:description)
    subclass = Class.new(Car) { translates :description }
    assert_equal true, subclass.translates?('description')
    assert_equal false, Car.translates?(:description)
    assert_equal false, Car.translates?('description')
  end
  
  test 'Translation of column names' do
    I18n.as(:de) { assert_equal :make_de, Car.translate_column_name(:make_t) }
    I18n.as(:en) { assert_equal :make, Car.translate_column_name(:make_t) }
    I18n.as(:de) { assert_equal :speed, Car.translate_column_name(:speed) }
    I18n.as(:en) { assert_equal :speed, Car.translate_column_name(:speed) }
  end
  
  test 'Translation column query methods' do
    assert_equal true,  Truck.translates?(:make)
    assert_equal true,  Truck.translates?('model')
    assert_equal false, Truck.translates?(:price)
    assert_equal false, Truck.translates?('price')
    assert_equal true,  Truck.translated_column_name?(:make)
    assert_equal true,  Truck.translated_column_name?(:make_de)
    assert_equal true,  Truck.translated_column_name?('model')
    assert_equal false, Truck.translated_column_name?(:price)
    assert_equal false, Truck.translated_column_name?('speed')
    assert_equal :en,   Truck.column_language_code(:make)
    assert_equal :de,   Truck.column_language_code(:model_de)
    assert_nil Truck.column_language_code(:price)
  end
end