class AddNomeFantasiaToOrganizacoes < ActiveRecord::Migration[6.0]
  def change
    add_column :organizacoes, :nome_fantasia, :string
    add_column :organizacoes, :inscricao_municipal, :string
    add_column :organizacoes, :inscricao_estadual, :string
  end
end
