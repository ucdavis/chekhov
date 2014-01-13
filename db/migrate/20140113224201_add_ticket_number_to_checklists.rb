class AddTicketNumberToChecklists < ActiveRecord::Migration
  def change
    add_column :checklists, :ticket_number, :integer
  end
end
