require 'test_helper'

class TemplateEntriesControllerTest < ActionController::TestCase
  setup do
    @template_entry = template_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:template_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create template_entry" do
    assert_difference('TemplateEntry.count') do
      post :create, template_entry: { content: @template_entry.content, position: @template_entry.position, template_id: @template_entry.template_id }
    end

    assert_redirected_to template_entry_path(assigns(:template_entry))
  end

  test "should show template_entry" do
    get :show, id: @template_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @template_entry
    assert_response :success
  end

  test "should update template_entry" do
    patch :update, id: @template_entry, template_entry: { content: @template_entry.content, position: @template_entry.position, template_id: @template_entry.template_id }
    assert_redirected_to template_entry_path(assigns(:template_entry))
  end

  test "should destroy template_entry" do
    assert_difference('TemplateEntry.count', -1) do
      delete :destroy, id: @template_entry
    end

    assert_redirected_to template_entries_path
  end
end
