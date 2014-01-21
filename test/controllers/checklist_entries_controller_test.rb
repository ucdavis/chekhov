require 'test_helper'

class ChecklistEntriesControllerTest < ActionController::TestCase
  setup do
    @checklist_entry = checklist_entries(:one)
  end

    assert_redirected_to checklist_entries_path
  end
end
