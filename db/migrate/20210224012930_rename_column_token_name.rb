class RenameColumnTokenName < ActiveRecord::Migration[6.0]
  def change
    rename_column :oauth_access_tokens, :model_name, :model_user_type

  end
end
