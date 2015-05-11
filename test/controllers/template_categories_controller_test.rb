require 'test_helper'

class TemplateCategoriesControllerTest < ActionController::TestCase
  setup do
    @template_category = template_categories(:one)
  end

  test "should get index" do
    grant_admin_access

    get :index, format: 'json'
    assert_response :success
    assert_not_nil assigns(:template_categories)
  end

  test "should create template_category" do
    grant_admin_access

    assert_difference('TemplateCategory.count') do
      post :create, format: 'json', template_category: { name: "A Template Category" }
    end

    assert_response :success
  end

  test "should show template_category" do
    grant_admin_access

    get :show, format: 'json', id: @template_category
    assert_response :success
  end

  test "should update template_category" do
    grant_admin_access

    patch :update, id: @template_category, format: 'json', template_category: { name: "A Template Category" }
    assert_response :success
  end

  test "should destroy template_category" do
    grant_admin_access

    assert_difference('TemplateCategory.count', -1) do
      delete :destroy, format: 'json', id: @template_category
    end

    assert_response :success
  end
end
