class AddArchivedToChecklists < ActiveRecord::Migration
  def change
    add_column :checklists, :archived, :boolean
  end
end
