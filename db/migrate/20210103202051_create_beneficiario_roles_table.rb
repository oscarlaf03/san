class CreateBeneficiarioRolesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :beneficiarios_roles do |t|
      t.references :beneficiario
      t.references :role
    end

    add_index(:beneficiarios_roles, [ :beneficiario_id, :role_id ])
  end
end
