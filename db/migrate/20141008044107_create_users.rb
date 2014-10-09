class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string "username", :limit => 35, :null => false
      t.string "email", :limit =>  100, :null => false
      t.string "first_name", :default => ""
      t.string "last_name", :defautl => ""
      
      t.timestamps
    end
  end
end
