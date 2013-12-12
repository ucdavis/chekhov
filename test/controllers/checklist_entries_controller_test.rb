require 'test_helper'

class ChecklistEntriesControllerTest < ActionController::TestCase
  setup do
    @checklist_entry = checklist_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:checklist_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create checklist_entry" do
    assert_difference('ChecklistEntry.count') do
      post :create, checklist_entry: { checklist_id: @checklist_entry.checklist_id, template_entry_id: @checklist_entry.template_entry_id, user_id: @checklist_entry.user_id }
    end

    assert_redirected_to checklist_entry_path(assigns(:checklist_entry))
  end

  test "should show checklist_entry" do
    get :show, id: @checklist_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @checklist_entry
    assert_response :success
  end

  test "should update checklist_entry" do
    patch :update, id: @checklist_entry, checklist_entry: { checklist_id: @checklist_entry.checklist_id, template_entry_id: @checklist_entry.template_entry_id, user_id: @checklist_entry.user_id }
    assert_redirected_to checklist_entry_path(assigns(:checklist_entry))
  end

  test "should destroy checklist_entry" do
    assert_difference('ChecklistEntry.count', -1) do
      delete :destroy, id: @checklist_entry
    end

    assert_redirected_to checklist_entries_path
  end
end
