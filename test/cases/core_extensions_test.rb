require File.expand_path('../../test_helper', __FILE__)

class CoreExtensionsTest < ActiveSupport::TestCase
  
  def setup
  end
  
  test 'string translation' do
    I18n.as :en do
      assert_equal 'One', 'words.one'.t
      assert_equal 'Two', 'words.two'.t
    end
    I18n.as :de do
      assert_equal 'Eins', 'words.one'.t
      assert_equal 'Zwei', 'words.two'.t
    end
  end
  
  test 'formatting of floats' do
    assert_equal '1.234,56', I18n.as('de') { 1234.56.to_formatted_s }, 'de'
    assert_equal '1,234.56', I18n.as('en') { 1234.56.to_formatted_s }, 'en'
  end
  
  test 'formatting of big decimals' do
    big_decimal = BigDecimal.new('1234.56')
    assert_equal '1,234.56', I18n.as('en') { big_decimal.to_formatted_s }, 'en'
    assert_equal '1.234,56', I18n.as('de') { big_decimal.to_formatted_s }, 'de'
  end

end