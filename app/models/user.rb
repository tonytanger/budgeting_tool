class User < ActiveRecord::Base

  has_secure_password

  has_many :accounts

  validates_presence_of :email, :first_name, :last_name

  validates_uniqueness_of :email
  
  scope :sorted, lambda { order("id ASC") }
end
