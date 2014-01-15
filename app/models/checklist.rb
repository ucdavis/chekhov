class Checklist < ActiveRecord::Base
  using_access_control
  after_save :notify_complete
  
  belongs_to :user
  has_many :entries, :class_name => 'ChecklistEntry', :dependent => :destroy
  
  validates_presence_of :user_id, :name, :template_name
  validates :public, :inclusion => {:in => [true, false]}
  
  before_create :set_start_time
  
  accepts_nested_attributes_for :entries
  
  private
  
  def set_start_time
    self.started = Time.now
  end
  
  def notify_complete
    if !self.finished.blank?
      message = "A checklist has been completed. Name: #{name}, Finished at: #{Time.now}"
      recipient = self.user.email
      subject = "Checklist completed"
      ChecklistMailer.send_email(message, recipient, subject).deliver
    end
  end
end
