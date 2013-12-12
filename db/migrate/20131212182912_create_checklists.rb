class CreateChecklists < ActiveRecord::Migration
  def change
    create_table :checklists do |t|
      t.integer :template_id
      t.boolean :public
      t.integer :user_id
      t.datetime :started
      t.datetime :finished

      t.timestamps
    end
  end
end
