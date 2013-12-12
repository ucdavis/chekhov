class CreateTemplateEntries < ActiveRecord::Migration
  def change
    create_table :template_entries do |t|
      t.integer :template_id
      t.text :content
      t.integer :position

      t.timestamps
    end
  end
end
