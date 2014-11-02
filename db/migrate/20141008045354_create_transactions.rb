class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :account_id, :null => false
      t.index :account_id
      t.decimal :cash_flow, :precision => 15, :scale => 2
      t.datetime :receipt_date
      t.text :note

      t.timestamps
    end
  end
end
