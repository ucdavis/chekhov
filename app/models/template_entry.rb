class TemplateEntry < ActiveRecord::Base
  using_access_control
  
  belongs_to :template
  
  validates_presence_of :content, :position
end
