require 'test_helper'

class TemplateEntryTest < ActiveSupport::TestCase
  test 'should not save Template Entry without content' do
    without_access_control do
      te = TemplateEntry.new
      te.content = nil
      te.position = 1
      assert !te.save
    end
  end 
  test 'should not save Template Entry without position' do
    without_access_control do
      te = TemplateEntry.new
      te.content = "I am an entry"
      te.position = nil
      assert !te.save
    end
  end   
end
