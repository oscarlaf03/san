class AddBeneficiarisoTitularKey < ActiveRecord::Migration[6.0]
  def change
    add_column :beneficiarios, :titular_id, :integer 
    add_foreign_key :beneficiarios, :beneficiarios ,column: 'titular_id'
  end
end
