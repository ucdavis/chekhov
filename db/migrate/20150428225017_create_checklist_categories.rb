class CreateChecklistCategories < ActiveRecord::Migration
  def change
    create_table :checklist_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
