class User < ActiveRecord::Base
  validates_presence_of :loginid, :rm_id
end
