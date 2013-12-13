class Checklist < ActiveRecord::Base
  using_access_control
  
  belongs_to :template
  belongs_to :user
  has_many :entries, :class_name => 'ChecklistEntry', :dependent => :destroy
  
  validates_presence_of :template, :user_id, :name
  validates :public, :inclusion => {:in => [true, false]}
  
  before_create :set_start_time
  after_create :create_checklist_entries
  
  private
  
  def set_start_time
    self.started = Time.now
  end
  
  # Checklist must exist and have a valid template
  # (should be ensured by being called in after_create)
  def create_checklist_entries
    Checklist.transaction do
      self.template.entries.each do |template_entry|
        self.entries << ChecklistEntry.create!({ position: template_entry.position, content: template_entry.content, checklist_id: self.id })
      end
    end
  end
end
