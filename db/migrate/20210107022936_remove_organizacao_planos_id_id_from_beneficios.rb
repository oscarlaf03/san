class RemoveOrganizacaoPlanosIdIdFromBeneficios < ActiveRecord::Migration[6.0]
  def change
    remove_column :beneficios, :organizacao_planos_id
  end
end
