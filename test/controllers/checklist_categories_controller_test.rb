require 'test_helper'

class ChecklistCategoriesControllerTest < ActionController::TestCase
  setup do
    @checklist_category = checklist_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:checklist_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create checklist_category" do
    assert_difference('ChecklistCategory.count') do
      post :create, checklist_category: {  }
    end

    assert_redirected_to checklist_category_path(assigns(:checklist_category))
  end

  test "should show checklist_category" do
    get :show, id: @checklist_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @checklist_category
    assert_response :success
  end

  test "should update checklist_category" do
    patch :update, id: @checklist_category, checklist_category: {  }
    assert_redirected_to checklist_category_path(assigns(:checklist_category))
  end

  test "should destroy checklist_category" do
    assert_difference('ChecklistCategory.count', -1) do
      delete :destroy, id: @checklist_category
    end

    assert_redirected_to checklist_categories_path
  end
end
