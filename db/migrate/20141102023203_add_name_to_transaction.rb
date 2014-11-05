class AddNameToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :description, :string, after: :account_id
    add_column :transactions, :current_balance, :decimal, precision: 15, scale: 2, after: :note
  end
end
