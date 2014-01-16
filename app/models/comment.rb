class Comment < ActiveRecord::Base
  using_access_control
  
  belongs_to :checklist
  
  validates_presence_of :checklist
end
