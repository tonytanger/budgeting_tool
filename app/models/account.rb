class Account < ActiveRecord::Base

  belongs_to :user
  has_many :transactions

  enum banking_type: [:chequing, :saving, :credit]

  validates :user_id, presence:true, numericality:{ only_integer: true }

  validates :account_number, presence: true, length: { maximum: 255 }

  validates :name, presence: true, length: { maximum: 255 }
  
  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :sorted, lambda { Account.sorted_by_id }
  scope :sorted_by_banking_type, lambda { order(:banking_type) }
  scope :sorted_by_id, lambda { order("id ASC") }
  scope :sorted_by_number, lambda { order("account_number ASC")}
  scope :sorted_by_date, lambda { order("created_at ASC")}
  scope :sorted_by_balance, lambda { order("balance ASC")}

end
