require 'test_helper'

class ChecklistCategoriesControllerTest < ActionController::TestCase
  setup do
    @checklist_category = checklist_categories(:one)
  end

  test "should get index" do
    grant_admin_access

    get :index, { :format => 'json' }
    assert_response :success
    assert_not_nil assigns(:checklist_categories)
  end

  test "should create checklist_category" do
    grant_admin_access

    assert_difference('ChecklistCategory.count') do
      post :create, { :format => 'json', :checklist_category => { :name => 'Test category' } }
    end

    assert_response :success
  end

  test "should show checklist_category" do
    grant_admin_access

    get :show, { :format => 'json', :id =>  @checklist_category }
    assert_response :success
  end

  test "should update checklist_category" do
    grant_admin_access

    patch :update, { format: 'json', id: @checklist_category, checklist_category: { :name => 'Test category' } }

    assert_response :success
  end

  test "should destroy checklist_category" do
    grant_admin_access

    assert_difference('ChecklistCategory.count', -1) do
      delete :destroy, { id: @checklist_category, format: 'json' }
    end

    assert_response :success
  end
end
