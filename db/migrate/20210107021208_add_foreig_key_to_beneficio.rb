class AddForeigKeyToBeneficio < ActiveRecord::Migration[6.0]
  def change
    # add_foreign_key :beneficios, :beneficiarios, column: :beneficiario_id
    add_reference :beneficios, :beneficiario, index: true
  end
end
