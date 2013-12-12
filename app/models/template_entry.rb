class TemplateEntry < ActiveRecord::Base
  belongs_to :template
  
  validates_presence_of :content, :position, :template_id
end
