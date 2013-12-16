class AddTemplateNameToChecklist < ActiveRecord::Migration
  def change
    add_column :checklists, :template_name, :string
  end
end
