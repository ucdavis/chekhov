class AddDescToChecklists < ActiveRecord::Migration
  def change
    add_column :checklists, :desc, :text
  end
end
