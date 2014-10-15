class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :account_id, :null => false
      t.index :account_id
      t.decimal :cash_flow, :precision => 20, :scale => 4, :default => 0
      t.text :note

      t.timestamps
    end
  end
end
