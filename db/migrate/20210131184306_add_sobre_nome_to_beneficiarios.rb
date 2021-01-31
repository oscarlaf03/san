class AddSobreNomeToBeneficiarios < ActiveRecord::Migration[6.0]
  def change
    add_column :beneficiarios, :sobre_nome, :string
  end
end
