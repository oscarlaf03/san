class CreateBeneficioCondicoes < ActiveRecord::Migration[6.0]
  def change
    create_table :beneficio_condicoes do |t|
      t.references :beneficio, null: false, foreign_key: true
      t.references :condicao, null: false, foreign_key: true

      t.timestamps
    end
  end
end
