require 'test_helper'

class SiteControllerTest < ActionController::TestCase
  test "should get access_denied" do
    get :access_denied
    assert_response :success
  end
end
