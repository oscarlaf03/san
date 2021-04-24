class AddMatrizIdToOrganizacoes < ActiveRecord::Migration[6.0]
  def change
    add_column :organizacoes, :matriz_id, :integer
    add_foreign_key :organizacoes, :organizacoes ,column: 'matriz_id'
  end
end
