class ChecklistEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :checklist
  belongs_to :entry, :class_name => 'TemplateEntry', :foreign_key => 'template_entry_id'
  
  validates_presence_of :checklist, :template_entry_id, :user
end
