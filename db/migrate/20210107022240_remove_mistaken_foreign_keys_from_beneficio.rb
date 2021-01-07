class RemoveMistakenForeignKeysFromBeneficio < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :beneficios, column: :beneficiarios_id
    remove_foreign_key :beneficios, column: :organizacao_planos_id
  end
end
