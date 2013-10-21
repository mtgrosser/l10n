require File.expand_path('../../test_helper', __FILE__)

class I18nExtensionsTest < ActiveSupport::TestCase
  
  test 'As scopes' do
    assert_equal :en, I18n.default_locale
    assert_equal :en, I18n.locale
    assert_equal :de, I18n.as(:de) { I18n.locale }
    assert_equal :en, I18n.locale
    begin
      I18n.as(:de) do
        assert_equal :de, I18n.locale
        raise
      end
    rescue
      assert_equal :en, I18n.locale
    end
    assert_equal :en, I18n.locale
    assert_equal :en, I18n.as(:de) { I18n.default_locale }
    assert_equal true, I18n.default?
    assert_equal false, I18n.as(:de) { I18n.default? }
    assert_equal :en, I18n.as(:de) { I18n.as_default { I18n.locale } }
  end
  
  test 'Availability helper methods' do
    assert_equal [:en, :de], I18n.available_language_codes
    assert_equal true, I18n.available?(:de)
    assert_equal true, I18n.available?(:en)
    assert_equal false, I18n.available?(:fr)
    assert_equal :de, I18n.available('de-DE')
    assert_nil I18n.available('gr-GR')  
  end

  test 'Default helper methods' do
    assert_equal true,  I18n.as(:en) { I18n.default? }
    assert_equal false, I18n.as(:de) { I18n.default? }
    assert_equal true,  I18n.as(:en) { I18n.default?(:en) }
    assert_equal false, I18n.as(:en) { I18n.default?(:de) }
    assert_equal true,  I18n.as(:de) { I18n.default?(:en) }
    assert_equal false, I18n.as(:de) { I18n.default?(:de) }
    assert_equal true,  I18n.as(:de) { I18n.default?('en') }
    assert_equal false, I18n.as(:de) { I18n.default?('de') }
  end
  
  test 'Translation suffix' do
    assert_equal '',    I18n.as(:en) { I18n.translation_suffix }
    assert_equal '_de', I18n.as(:de) { I18n.translation_suffix }
    assert_equal '_de', I18n.as(:de) { I18n.translation_suffix('de') }
    assert_equal '_de', I18n.as(:de) { I18n.translation_suffix(:de) }
    assert_equal '',    I18n.as(:de) { I18n.translation_suffix(:en) }
    assert_equal '',    I18n.as(:en) { I18n.translation_suffix(:en) }
    assert_equal '_de', I18n.as(:en) { I18n.translation_suffix(:de) }
  end
end
