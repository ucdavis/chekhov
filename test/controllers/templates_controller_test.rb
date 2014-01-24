require 'test_helper'

class TemplatesControllerTest < ActionController::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("guilden")
    @template = templates(:one)
  end
  
  test "should destroy template" do
    assert_difference('Template.count', -1) do
      delete :destroy, :format => :json, id: @template.id
    end
  end
  
  test "should destroy template entries when template is destroyed" do
      entries = @template.entries
      delete :destroy, :format => :json, id: @template.id
      assert entries.blank?
  end
  
  test "should get template index" do
      get :index
      assert_response :success
  end
  

end
