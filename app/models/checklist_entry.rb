class ChecklistEntry < ActiveRecord::Base
  using_access_control
  
  belongs_to :checklist
  
  validates_presence_of :checklist
  
  before_save :clear_user_id_if_unchecking
  
  private
  def clear_user_id_if_unchecking
    if self.checked == false
      self.completed_by = nil
    end
  end
end
