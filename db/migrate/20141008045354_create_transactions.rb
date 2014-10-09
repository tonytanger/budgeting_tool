class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer "account_id", :limit => 11, :null => false
      t.index "account_id"
      t.integer "cash_flow", :limit => 11, :default => 0
      t.text "note"

      t.timestamps
    end
  end
end
