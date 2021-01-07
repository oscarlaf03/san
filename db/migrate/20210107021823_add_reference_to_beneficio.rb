class AddReferenceToBeneficio < ActiveRecord::Migration[6.0]
  def change
    add_reference :beneficios, :organizacao_plano, index: true

  end
end
