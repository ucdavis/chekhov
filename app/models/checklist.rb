class Checklist < ActiveRecord::Base
  using_access_control :include_read => true
  after_save :notify_complete
  
  belongs_to :user
  has_many :entries, :class_name => 'ChecklistEntry', :dependent => :destroy, :order => "position"
  has_many :comments, :dependent => :destroy, :order => "created_at"
  
  validates_presence_of :user_id, :name, :template_name
  validates :public, :inclusion => {:in => [true, false]}
  
  before_create :set_start_time
  
  accepts_nested_attributes_for :entries
  accepts_nested_attributes_for :comments

  def finished_by
    self.entries.order(finished: :desc).first.completed_by
  end

  private
  
  def set_start_time
    self.started = Time.now
  end
  
  def notify_complete
    if !self.finished.blank? && !self.user.blank?
      message = "A checklist has been completed. Name: #{name}, Finished at: #{Time.now}"
      recipient = self.user.email
      subject = "Checklist completed"
      ChecklistMailer.send_email(message, recipient, subject).deliver
    end
  end


  #
  # time_elapsed
  # 
  #   Gives time it took to finish a checklist in minutes.
  #
  
  def time_elapsed
    if !self.finished.blank?
        ((self.finished - self.started) / 60).to_i
    end
  end

  def find_finished_by(ckl)
    ckl.entries.order(finished :desc).first
  end
end
