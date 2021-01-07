class CreateCondicoes < ActiveRecord::Migration[6.0]
  def change
    create_table :condicoes do |t|
      t.float :subisidio_titular
      t.float :subsidio_dependente
      t.references :organizacao, null: false, foreign_key: true

      t.timestamps
    end
  end
end
