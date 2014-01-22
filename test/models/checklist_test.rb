require 'test_helper'

class ChecklistTest < ActiveSupport::TestCase
  test 'should not save checklist without template name' do
    without_access_control do
      e = Checklist.new
      e.public = true
      e.user_id = 1
      e.started = Time.now
      e.name = "good checklist"
      e.ticket_number = 123456
      e.template_name = nil
      assert !e.save
    end
  end
  test 'should not save checklist without user_id' do
    without_access_control do  
      e = Checklist.new
      e.public = true
      e.user_id = nil
      e.started = Time.now
      e.name = "good checklist"
      e.template_name = "template here"
      e.ticket_number = 123456
      assert !e.save
    end
  end
  test 'should not save checklist without name' do
    without_access_control do
      e = Checklist.new
      e.public = true
      e.user_id = 1
      e.started = Time.now
      e.name = nil
      e.template_name = "template here"
      e.ticket_number = 123456
      assert !e.save
    end
  end  

end
