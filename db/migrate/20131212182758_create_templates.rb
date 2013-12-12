class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.integer :owner_id
      t.string :name

      t.timestamps
    end
  end
end
