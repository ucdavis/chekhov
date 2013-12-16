require 'test_helper'

class SiteControllerTest < ActionController::TestCase
  test "should get welcome" do
    get :welcome
    assert_response :success
  end

  test "should get access_denied" do
    get :access_denied
    assert_response :success
  end

end
