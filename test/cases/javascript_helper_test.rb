require_relative '../test_helper'

class JavaScriptHelperTest < ActiveSupport::TestCase

  setup do
    @template = Object.new
    @template.extend ActionView::Helpers::TagHelper
    @template.extend ActionView::Helpers::JavaScriptHelper
    @template.extend L10n::JavaScriptHelper
  end
  
  test 'The I18n javascript is rendered' do
    I18n.as :en do
      assert_include @template.i18n_script_tag, '{"test":"Hello JS!"};'
    end
    I18n.as :de do
      assert_include @template.i18n_script_tag, '{"test":"Hallo JS!"};'
    end
  end
end