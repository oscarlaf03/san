class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :name_model
      t.integer :id_model
      t.string :params
      t.string :action
      t.boolean :canceled, default: false
      t.boolean :open, default: true
      t.integer :requestor_id, null: false, foreign_key: true
      t.integer :owner_id, null: true, foreign_key: true
      t.datetime :closed_at

      t.timestamps
    end
  end
end
