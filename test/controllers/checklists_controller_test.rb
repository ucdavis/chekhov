require 'test_helper'

class ChecklistsControllerTest < ActionController::TestCase
  setup do
    @checklist = checklists(:one)
  end


    assert_redirected_to checklists_path
  end
end
