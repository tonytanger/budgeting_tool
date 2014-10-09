class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer "user_id", :limit => 11, :null => false
      t.index "user_id"
      t.string "name", :limit => 35, :null => false
      t.integer "balance", :limit => 11, :default => 0
      t.text "description"

      t.timestamps
    end
  end
end
