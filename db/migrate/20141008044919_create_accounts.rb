class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id, :null => false
      t.index :user_id
      t.string :name, :null => false
      t.string :account_number
      t.integer :balance, :default => 0
      t.text :description

      t.timestamps
    end
  end
end
