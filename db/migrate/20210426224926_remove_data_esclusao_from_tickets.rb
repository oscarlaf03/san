class RemoveDataEsclusaoFromTickets < ActiveRecord::Migration[6.0]
  def change
    remove_column :tickets, :data_inclusao
    remove_column :tickets, :data_exclusao
    add_column :tickets, :data_vigor, :date
  end
end
