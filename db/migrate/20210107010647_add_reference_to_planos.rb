class AddReferenceToPlanos < ActiveRecord::Migration[6.0]
  def change
    add_reference :planos , :seguradora, index: true
    # remove_reference :planos, :aseguradora 
  end
end
