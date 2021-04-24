class AddDataInclusaoDataExclusaoToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :data_inclusao, :date
    add_column :tickets, :data_exclusao, :date
  end
end
