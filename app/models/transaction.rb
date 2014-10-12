class Transaction < ActiveRecord::Base

  belongs_to :account

  scope :sorted, lambda { order("id ASC")}

  def user_id
    Account.find_by_id( self.account_id ).user_id
  end
end
