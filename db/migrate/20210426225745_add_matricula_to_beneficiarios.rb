class AddMatriculaToBeneficiarios < ActiveRecord::Migration[6.0]
  def change
    add_column :beneficiarios, :matricula, :string
  end
end
