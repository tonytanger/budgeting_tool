class AddPasswordUser < ActiveRecord::Migration
  def up
    add_column(:users, "password", :string, :limit => 32, :null =>false)
  end

  def down
    remove_column(:users, "password")
  end
end
