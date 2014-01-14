class AddCommentsToChecklists < ActiveRecord::Migration
  def change
    add_column :checklists, :comments, :text
  end
end
