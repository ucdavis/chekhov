class Template < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  has_many :entries, :class_name => 'TemplateEntry'
  
  validates_presence_of :owner, :name
end
