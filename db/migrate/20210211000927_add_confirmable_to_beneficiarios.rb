class AddConfirmableToBeneficiarios < ActiveRecord::Migration[6.0]
  def up
    add_column :beneficiarios, :confirmation_token, :string
    add_column :beneficiarios, :confirmed_at, :datetime
    add_column :beneficiarios, :confirmation_sent_at, :datetime
    add_index :beneficiarios, :confirmation_token, unique: true
    Beneficiario.update_all confirmed_at: DateTime.now
  end

  def def down
    drop_table :table_name
    remove_index :beneficiarios, :confirmation_token
    remvoe_columns :beneficiarios, :confirmation_token, :confirmed_at, :confirmation_sent_at
  end
end
