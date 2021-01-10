class CreateEnderecos < ActiveRecord::Migration[6.0]
  def change
    create_table :enderecos do |t|
      t.string :logradouro
      t.string :numero
      t.string :complemento
      t.string :bairro
      t.string :cidade
      t.string :estado
      t.string :cep
      t.references :organizacao, null: true, foreign_key: true
      t.references :beneficiario, null: true, foreign_key: true

      t.timestamps
    end
  end
end
