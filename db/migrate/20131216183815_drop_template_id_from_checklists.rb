class DropTemplateIdFromChecklists < ActiveRecord::Migration
  def change
    remove_column :checklists, :template_id
  end
end
