class User < ActiveRecord::Base
  using_access_control
  
  validates_presence_of :loginid, :rm_id
  
  def role_symbols
    RolesManagement.fetch_role_symbols_by_loginid(loginid)
  end
end
