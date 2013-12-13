class Template < ActiveRecord::Base
  using_access_control
  
  belongs_to :owner, :class_name => 'User'
  has_many :entries, :class_name => 'TemplateEntry'
  
  validates_presence_of :owner, :name
  accepts_nested_attributes_for :entries
end
