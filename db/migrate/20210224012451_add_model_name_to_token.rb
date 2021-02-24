class AddModelNameToToken < ActiveRecord::Migration[6.0]
  def change
    add_column :oauth_access_tokens, :model_name, :string
  end
end

