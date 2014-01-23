require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should not save User without email' do
    without_access_control do
      u = User.new
      u.loginid = "bob"
      u.rm_id = 12345
      u.email = nil
      assert !u.save
    end
  end  
  test 'should not save User without rm_id' do
    without_access_control do
      u = User.new
      u.loginid = "bob"
      u.rm_id = nil
      u.email = "bob@gmail.com"
      assert !u.save
    end
  end  
  test 'should not save User without loginid' do
    without_access_control do
      u = User.new
      u.loginid = nil
      u.rm_id = 12345
      u.email = "bob@gmail.com"
      assert !u.save
    end
  end  
end
