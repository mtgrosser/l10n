require_relative '../test_helper'

class RequestTest < ActiveSupport::TestCase

  test 'accept locales' do
    request = ActionDispatch::Request.new('HTTP_ACCEPT_LANGUAGE' => "en-US,en;q=0.8,en-GB;q=0.6,fr-CA;q=0.4,fr;q=0.2")
    assert_equal %w(en-US en en-GB fr-CA fr), request.accept_locales
    request = ActionDispatch::Request.new('HTTP_ACCEPT_LANGUAGE' => "en-US,en;q=0.8,en-GB;q=0.6,fr-CA;q=0.9,fr;q=0.2")
    assert_equal %w(en-US fr-CA en en-GB fr), request.accept_locales
  end
  
  test 'malformed header with spaces does not raise exception' do
    request = ActionDispatch::Request.new('HTTP_ACCEPT_LANGUAGE' => 'en-US,en; q=0.8,fr-FR; q=0.9')
    assert_equal %w(en-US fr-FR en), request.accept_locales
    request = ActionDispatch::Request.new('HTTP_ACCEPT_LANGUAGE' => 'en-US,en; q=0.8')
    assert_equal %w(en-US en), request.accept_locales
  end

end
