class AddDescToTemplates < ActiveRecord::Migration
  def change
    add_column :templates, :desc, :text
  end
end
