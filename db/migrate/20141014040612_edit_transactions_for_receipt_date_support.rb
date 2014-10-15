class EditTransactionsForReceiptDateSupport < ActiveRecord::Migration
  def up
    add_column(:transactions, "receipt_date", :datetime, :after => "cash_flow")
  end

  def down
    remove_column(:transactions, "receipt_date")
  end
end
