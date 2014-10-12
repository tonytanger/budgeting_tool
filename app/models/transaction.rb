class Transaction < ActiveRecord::Base

  belongs_to :account

  scope :sorted, lambda { order("id ASC")}
end
