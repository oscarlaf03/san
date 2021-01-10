class CreateContaBancarias < ActiveRecord::Migration[6.0]
  def change
    create_table :conta_bancarias do |t|
      t.string :banco
      t.string :codigo_banco
      t.string :agencia
      t.string :conta
      t.references :beneficiario, null: false, foreign_key: true

      t.timestamps
    end
  end
end
