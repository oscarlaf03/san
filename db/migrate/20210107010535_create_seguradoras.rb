class CreateSeguradoras < ActiveRecord::Migration[6.0]
  def change
    create_table :seguradoras do |t|
      t.string :cnpj
      t.string :razao_social
      t.string :nome

      t.timestamps
    end
  end
end
