# encoding: utf-8

require "bigdecimal"
require "date"

require File.expand_path('../../test_helper', __FILE__)

class CoreExtensionsTest < ActiveSupport::TestCase
  
  test 'String translation' do
    I18n.as :en do
      assert_equal 'One', 'words.one'.t
      assert_equal 'Two', 'words.two'.t
    end
    I18n.as :de do
      assert_equal 'Eins', 'words.one'.t
      assert_equal 'Zwei', 'words.two'.t
    end
  end
  
  test 'Symbol translation' do
    I18n.as :en do
      assert_equal 'One', :'words.one'.t
    end
    I18n.as :de do
      assert_equal 'Zwei', :'words.two'.t
    end
  end
  
  test 'Formatting of floats' do
    assert_equal '1.234,50', I18n.as('de') { 1234.5.to_formatted_s }, 'de'
    assert_equal '1,234.50', I18n.as('en') { 1234.5.to_formatted_s }, 'en'
  end
  
  test 'Formatting of big decimals' do
    big_decimal = BigDecimal.new('1234.5')
    assert_equal '1,234.50', I18n.as('en') { big_decimal.to_formatted_s }, 'en'
    assert_equal '1.234,50', I18n.as('de') { big_decimal.to_formatted_s }, 'de'
  end
  
  test 'Original BigDecimal to_s is not overridden by l10n' do
    big_decimal = BigDecimal.new('6.5')
    assert_equal '6.5', I18n.as('en') { big_decimal.to_s }, 'en'
    assert_equal '6.5', I18n.as('de') { big_decimal.to_s }, 'de'
    # 'F' format is used in ActiveRecord::ConnectionAdapters::Quoting
    assert_equal '6.5', I18n.as('en') { big_decimal.to_s('F') }, 'en'
    assert_equal '6.5', I18n.as('de') { big_decimal.to_s('F') }, 'de'
  end
  
  test 'Localization of numeric strings' do
    assert_equal '1.234,50', I18n.as(:de) { Numeric.localize('1,234.50') }
    assert_equal '1,234.50', I18n.as(:en) { Numeric.localize('1,234.50') }
  end
  
  test 'Localization of numbers' do
    assert_equal '1234,5', I18n.as(:de) { 1234.5.to_localized_s }
    assert_equal '1234.5', I18n.as(:en) { 1234.5.to_localized_s }
  end
  
  test 'Object#to_localized_s is defined' do
    assert Object.new.to_localized_s
  end
  
  test 'Date localization' do
    assert_equal 'January 01, 2010', I18n.as(:en) { '2010-01-01'.to_date.l(:format => :long) }
    assert_equal '01. Januar 2010', I18n.as(:de) { '2010-01-01'.to_date.l(:format => :long) }
  end

end