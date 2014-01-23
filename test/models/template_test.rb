require 'test_helper'

class TemplateTest < ActiveSupport::TestCase
  test 'should not save Template without name' do
    without_access_control do
      t = Template.new
      t.owner_id = 1
      t.name = nil
      assert !t.save
    end
  end  
  test 'should not save Template without owner' do
    without_access_control do
      t = Template.new
      t.owner_id = nil
      t.name = "best template"
      assert !t.save
    end
  end  
end
