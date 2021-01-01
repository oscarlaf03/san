class CreateAseguradoras < ActiveRecord::Migration[6.0]
  def change
    create_table :aseguradoras do |t|
      t.string :cnpj
      t.string :razao_social
      t.string :nome

      t.timestamps
    end
  end
end
