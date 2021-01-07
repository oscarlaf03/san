class RemoveBeneficiariosIdFromBeneficios < ActiveRecord::Migration[6.0]
  def change
    remove_column :beneficios, :beneficiarios_id
  end
end
