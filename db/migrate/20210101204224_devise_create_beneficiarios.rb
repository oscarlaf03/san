# frozen_string_literal: true

class DeviseCreateBeneficiarios < ActiveRecord::Migration[6.0]
  def change
    create_table :beneficiarios do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      t.string :nome
      t.string :nacionalidade
      t.string :cpf
      t.string :sexo
      t.date :data_nascimento
      t.string :estado_civil
      t.string :nome_da_mae
      t.string :telefone
      t.string :cargo
      t.date :admissao
      t.integer :salario
      t.string :papel
      t.references :organizacao, index: true

      t.timestamps null: false
    end

    add_index :beneficiarios, :email,                unique: true
    add_index :beneficiarios, :reset_password_token, unique: true
    # add_index :beneficiarios, :confirmation_token,   unique: true
    # add_index :beneficiarios, :unlock_token,         unique: true
  end
end
