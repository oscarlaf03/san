class CreateOrganizacaoPlanos < ActiveRecord::Migration[6.0]
  def change
    create_table :organizacao_planos do |t|
      t.references :plano, null: false, foreign_key: true
      t.references :organizacao, null: false, foreign_key: true

      t.timestamps
    end
  end
end
