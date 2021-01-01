class CreateOrganizacoes < ActiveRecord::Migration[6.0]
  def change
    create_table :organizacoes do |t|
      t.string :slug
      t.string :razao_social
      t.string :cnpj

      t.timestamps
    end
  end
end
