class AddParentescoToBeneficiarios < ActiveRecord::Migration[6.0]
  def change
    add_column :beneficiarios, :parentesco, :string
  end
end
