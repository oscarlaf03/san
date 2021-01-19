class CreatePlanos < ActiveRecord::Migration[6.0]
  def change
    create_table :planos do |t|
      t.string :nome
      t.integer :premio_mensal
      t.string :papel
      t.string :acomodacao
      # t.references :aseguradora, null: false, foreign_key: true

      t.timestamps
    end
  end
end
