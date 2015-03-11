class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.references :user, index: true
      t.integer :session_id
      t.integer :ip_address
      t.text :user_agent

      t.timestamps
    end
  end
end
