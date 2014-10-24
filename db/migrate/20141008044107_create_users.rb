class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :limit =>  100, :null => false
      t.string :password_digest
      t.string :first_name, :default => ""
      t.string :last_name, :default => ""
      
      t.timestamps
    end
  end
end
