class Template < ActiveRecord::Base
  using_access_control
  
  belongs_to :owner, :class_name => 'User'
  belongs_to :template_category
  has_many :entries, :class_name => 'TemplateEntry', :dependent => :destroy, :order => "position"
  
  validates_presence_of :owner, :name
  validates_uniqueness_of :name
  
  accepts_nested_attributes_for :entries,  :allow_destroy => true
end
