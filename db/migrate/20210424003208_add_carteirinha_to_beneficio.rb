class AddCarteirinhaToBeneficio < ActiveRecord::Migration[6.0]
  def change
    add_column :beneficios, :carteirinha, :string
  end
end
