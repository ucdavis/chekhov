class ChangeIpToString < ActiveRecord::Migration
  def change
    change_column :visits, :ip_address, :text
  end
end
