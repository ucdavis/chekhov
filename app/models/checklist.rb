class Checklist < ActiveRecord::Base
  using_access_control
  
  belongs_to :template
  belongs_to :user
  has_many :entries, :class_name => 'ChecklistEntry', :dependent => :destroy
  
  validates_presence_of :template, :user_id, :name
  validates :public, :inclusion => {:in => [true, false]}
end
