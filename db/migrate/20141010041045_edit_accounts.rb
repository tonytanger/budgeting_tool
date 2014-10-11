class EditAccounts < ActiveRecord::Migration
  def up
    add_column :accounts, "account_number", :string
  end

  def down
    remove_column :accounts, "account_number"
  end
end
