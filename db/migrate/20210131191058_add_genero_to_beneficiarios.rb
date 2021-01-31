class AddGeneroToBeneficiarios < ActiveRecord::Migration[6.0]
  def change
    add_column :beneficiarios, :genero, :string
  end
end
