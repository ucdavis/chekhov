class Checklist < ActiveRecord::Base
  belongs_to :template
  belongs_to :user
  has_many :entries, :class_name => 'ChecklistEntry'
  
  validates_presence_of :template, :user_id
  validates :public, :inclusion => {:in => [true, false]}
end
