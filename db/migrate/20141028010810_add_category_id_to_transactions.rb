class AddCategoryIdToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :category_id, :integer, after: :account_id
    add_index :transactions, :category_id
  end
end
