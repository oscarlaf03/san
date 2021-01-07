class CreateBeneficios < ActiveRecord::Migration[6.0]
  def change
    create_table :beneficios do |t|
      t.references :beneficiarios, null: false, foreign_key: true
      t.references :organizacao_planos, null: false, foreign_key: true

      t.timestamps
    end
  end
end
