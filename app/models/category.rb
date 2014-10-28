class Category < ActiveRecord::Base

  has_many :transactions

  validates :name, presence: true, length: { maximum: 200 }
  validates :description, presence: true, length: { maximum: 200 }

  scope :sorted, lambda { order("name ASC") }
  scope :sorted_names, lambda { select("name, id").order("name ASC")}
end
