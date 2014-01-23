require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test 'should not save comment without checklist' do
    without_access_control do
      c  = Comment.new
      c.content = "this is a comment"
      c.author = "bill"
      c.checklist = nil
      assert !c.save
    end
  end  
end
