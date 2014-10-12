class ChangeDatabaseNameFormat < ActiveRecord::Migration

  def change
    rename_column :accounts, :account_number, :accountNumber
    rename_column :transactions, :cash_flow, :cashFlow
    rename_column :users, :first_name, :firstName
    rename_column :users, :last_name, :lastName
  end
  
end
