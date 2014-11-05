class AddTypeToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :banking_type, :integer
  end
end
