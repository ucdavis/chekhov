class ChecklistEntry < ActiveRecord::Base
  using_access_control
  
  belongs_to :user
  belongs_to :checklist
  
  validates_presence_of :checklist
end
