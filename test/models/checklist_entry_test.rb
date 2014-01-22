require 'test_helper'

class ChecklistEntryTest < ActiveSupport::TestCase
  
  test "should delete entries when checklist is deleted" do
    without_access_control do
      c = Checklist.first
      e = c.entries
      c.destroy
      assert(e.empty?) 
    end
  end
  
  test "should clear completed_by when unchecking an entry" do
    without_access_control do 
      e = ChecklistEntry.where(content: "this one starts checked").first # This entry starts out with all fields filled
      f = e.checked
      e.checked = false
      e.save!
      assert(e.completed_by.blank?, "completed_by was not cleared as expected")
    end
  end
end
