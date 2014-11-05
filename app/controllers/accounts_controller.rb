class AccountsController < ApplicationController

  before_action :confirmed_signed_in
  before_action :confirm_id, only: [:show, :edit, :update, :destroy]

  def index
    
    # find all the accounts belong to the user
    accounts = User.find(session[:current_user_id]).accounts.sorted_by_banking_type

    # create a hash to group accounts based on the banking type
    # key is a banking type and value is an array of accounts
    @grouped_accounts = Hash.new
    
    # do the same, but keeping track of the total
    @grouped_total = Hash.new
    
    # for each banking_type add a new key to @grouped_accounts and @grouped_total
    Account.banking_types.each { |key, value|
      @grouped_accounts[key] = Array.new
      @grouped_total[key] = 0
    }
    
    # for each account, sort them according to their banking_type
    # insert the account into the hash of arrays
    accounts.each do |account|
      @grouped_accounts[account.banking_type] << account
      @grouped_total[account.banking_type] += account.balance
    end

    # calculate grand total
    @grand_total = 0
    @grouped_total.each do |group_name, subtotal|
      if group_name == "credit"
        @grand_total -= subtotal
      else
        @grand_total += subtotal
      end
    end
  end

  def show
    if params.has_key?(:id)
      @account = Account.find_by_id(params[:id])
      if @account.user_id != session[:current_user_id]
        # user try to access an account that doesn't belong to them
        redirect_to(controller: :users, action: :sign_out)
      end
      @transactions = @account.transactions.sorted_by_reverse_date
      @cash_flow_total = sum_cash_flow(@transactions)
    else 
      redirect_to(action: "index")
    end
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)
    @account.user_id = session[:current_user_id]

    if @account.save
      flash[:notice] = "Account #{@account.name} created successfully."
      redirect_to( action: "index" )
    else
      render("new")
    end
  end

  def edit
    @account = Account.find_by_id(params[:id])
  end

  def update
    @account = Account.find_by_id(params[:id])
    
    if @account.update_attributes(account_params)
      flash[:notice] = "Account #{@account.name} updated successfully."
      redirect_to( action: "show", id: @account.id )
    else
      render("new")
    end
  end

  def destroy
    account = Account.find_by_id(params[:id]).destroy
    flash[:notice] = "Account #{account.name} deleted successfully."
    redirect_to( action: "index" )
  end

  private 

    def account_params
      # TODO: restirct user_id param field by form
      params.require(:account).permit(:bank_name, :name, :user_id, :balance, :account_number, :description, :banking_type)
    end

end
