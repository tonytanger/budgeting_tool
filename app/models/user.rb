class User < ActiveRecord::Base

  has_many :accounts
  
  scope :sorted, lambda { order("id ASC") }
end
