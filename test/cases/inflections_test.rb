require File.expand_path('../../test_helper', __FILE__)

class InflectionsTest < ActiveSupport::TestCase
  
  test 'Ordinals' do
    numbers = [1, 2, 3, 4, 11, 31, 101]
    assert_equal %w[st nd rd th th st st], I18n.as(:en) { numbers.map { |n| ActiveSupport::Inflector.ordinal(n) } }
    assert_equal %w[. . . . . . .], I18n.as(:de) { numbers.map { |n| ActiveSupport::Inflector.ordinal(n) } }
  end
  
  test 'Ordinalize' do
    numbers = [1, 2, 3, 4, 11, 31, 101]
    assert_equal %w[1st 2nd 3rd 4th 11th 31st 101st], I18n.as(:en) { numbers.map { |n| n.ordinalize } }
    assert_equal %w[1. 2. 3. 4. 11. 31. 101.], I18n.as(:de) { numbers.map { |n| n.ordinalize } }
  end
end