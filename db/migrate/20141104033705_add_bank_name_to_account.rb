class AddBankNameToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :bank_name, :string, after: :user_id
  end
end
