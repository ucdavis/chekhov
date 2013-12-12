class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :loginid
      t.integer :rm_id

      t.timestamps
    end
  end
end
