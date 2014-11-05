class Transaction < ActiveRecord::Base

  belongs_to :account

  belongs_to :category

  validates_presence_of :account_id, :description, :cash_flow, :receipt_date

  scope :sorted, lambda { order("id ASC") }
  scope :sorted_by_reverse_date, lambda { order("receipt_date DESC") }
  scope :sorted_by_date, lambda { order("receipt_date ASC") }

  def user_id
    Account.find_by_id( self.account_id ).user_id
  end

end
