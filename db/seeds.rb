# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(password: "test123", password_confirmation: "test123", email: "abc1@abc", first_name: "john", last_name: "doe")
User.create(password: "test123", password_confirmation: "test123", email: "abc2@abc", first_name: "john", last_name: "doe")
User.create(password: "test123", password_confirmation: "test123", email: "abc3@abc", first_name: "john", last_name: "doe")

Account.chequing.create(user_id: 1, name: "account 1", balance: 500, account_number: "123456", description: "hello world")
Account.credit.create(user_id: 1, name: "account 2", balance: 300, account_number: "123456", description: "hello world")
Account.saving.create(user_id: 2, name: "account 3", balance: 1240, account_number: "123456", description: "hello world")

Transaction.create(account_id: 1, category_id: 1, description: "transaction 1", receipt_date: Date.current, current_balance: 600, cash_flow: 600, note: "hello world")
Transaction.create(account_id: 1, category_id: 2, description: "transaction 2", receipt_date: Date.current, current_balance: 500, cash_flow: -100, note: "hello world")
Transaction.create(account_id: 2, category_id: 3, description: "transaction 3", receipt_date: Date.current, current_balance: -200, cash_flow: -200, note: "hello world")

(1..10).each do |i|
  Category.create(name: "category_#{i}", description: "description_#{i}")
end
