class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, :limit => 35, :null => false
      t.string :password, :limit => 32, :null =>false
      t.string :email, :limit =>  100, :null => false
      t.string :firstName, :default => ""
      t.string :lastName, :default => ""
      
      t.timestamps
    end
  end
end
