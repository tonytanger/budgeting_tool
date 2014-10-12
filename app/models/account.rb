class Account < ActiveRecord::Base

  belongs_to :user
  has_many :transactions
  
  scope :sorted, lambda { Account.sorted_by_number }
  scope :sorted_by_id, lambda { order("id ASC") }
  scope :sorted_by_number, lambda { order("account_number ASC")}
  scope :sorted_by_date, lambda { order("created_at ASC")}
  scope :sorted_by_balance, lambda { order("balance ASC")}
end
