class DropCommentsFromChecklists < ActiveRecord::Migration
  def change
    remove_column :checklists, :comments
  end
end
