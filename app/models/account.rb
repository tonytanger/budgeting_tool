class Account < ActiveRecord::Base

  belongs_to :user
  has_many :transactions
  
  scope :sorted, lambda { :sorted_by_number }
  scope :sorted_by_id, lambda { order("accounts.id ASC") }
  score :sorted_by_number, lambda { order("accounts.account_number ASC")}
  scope :sorted_by_date, lambda { order("accounts.created_at ASC")}
  scope :sorted_by_balance, lambda { order("balance ASC")}
end
