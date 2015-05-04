class CreateTemplateCategories < ActiveRecord::Migration
  def change
    create_table :template_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
