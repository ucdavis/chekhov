class AddForcePrivateToTemplates < ActiveRecord::Migration
  def change
    add_column :templates, :force_private, :boolean
  end
end
