class AddTypeOfRoleToAccounts < ActiveRecord::Migration
  def change
    # In the future, there may be a whole separate "roles" table, but for now just a string field
    add_column :accounts, :their_role, :string, :limit => 50
  end
end
