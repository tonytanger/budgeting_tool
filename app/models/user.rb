class User < ActiveRecord::Base

  has_many :accounts

  validates_presence_of :username, :password, :email, :first_name, :last_name
  
  scope :sorted, lambda { order("id ASC") }
end
