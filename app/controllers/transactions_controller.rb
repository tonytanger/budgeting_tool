class TransactionsController < ApplicationController

  before_action :confirmed_signed_in
  before_action :confirmed_account_id, only: [:new, :create]
  before_action :confirm_id, only: [:show, :edit, :update, :destroy]

  def index
    @transactions = Transaction.sorted
  end

  def show
    @transaction = Transaction.find_by_id(params[:id])
  end

  def new
    if params[:account_id]
      @transaction = Transaction.new
      @transaction.account_id = params[:account_id]
      @categories = Category.sorted_names
    else
      flash[:error] = "Missing account id, please try again!"
      redirect_to(controller: "accounts", action: "index")
    end
  end

  def create
    @transaction = Transaction.new(create_params)

    if @transaction.save
      flash[:success] = "transaction ##{@transaction.id} created successfully."
      redirect_to( action: "index" )
    else
      render("new")
    end
  end

  def edit
    @transaction = Transaction.find_by_id(params[:id])
    @categories = Category.sorted_names
  end

  def update
    @transaction = Transaction.find_by_id(params[:id])
    # BUG: check transaction.account_id.user_id is current_user_id
    if @transaction.update_attributes(update_params)
      flash[:success] = "transaction ##{@transaction.id} updated successfully."
      redirect_to( action: "show", id: @transaction.id )
    else
      render("new")
    end
  end

  def destroy
    transaction = Transaction.find_by_id(params[:id]).destroy
    flash[:success] = "transaction ##{transaction.id} deleted successfully."
    redirect_to( action: "index" )
  end

  private

  def create_params
    params.require(:transaction).permit(:account_id, :category_id, :description, :cash_flow, :note, :receipt_date)
  end

  def update_params
    params.require(:transaction).permit(:category_id, :description, :note, :cash_flow, :receipt_date)
  end

  def confirmed_account_id
    id = nil
    # is account_id set?
    # or is account_id passed in the form?
    if params[:account_id]
      id = params[:account_id]
    elsif params[:transaction] and params[:transaction][:account_id]
      id = params[:transaction][:account_id]
    end

    # is id set? and does the account exist? and does this account belong to the current user?
    if id and account = Account.find_by_id(id) and 
      account.user_id == session[:current_user_id]
        return true
    else
      redirect_to(controller: "accounts", action: "index")
      return false
    end
  end
end
