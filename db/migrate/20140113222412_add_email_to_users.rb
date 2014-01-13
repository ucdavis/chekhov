class AddEmailToUsers < ActiveRecord::Migration
  def change
    add_column :Users, :email, :string
  end
end
