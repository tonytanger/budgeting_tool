class AccountsController < ApplicationController
  layout false
  def index
    @accounts = Account.sorted
  end

  def show
    @account = Account.find_by_id(params[:id])
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)

    if @account.save
      flash[:notice] = "Account #{@account.name} created successfully."
      redirect_to( :action => "index" )
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
      redirect_to( :action => "show", :id => @account.id )
    else
      render("new")
    end
  end

  def destroy
    account = Account.find_by_id(params[:id]).destroy
    flash[:notice] = "Account #{account.name} deleted successfully."
    redirect_to( :action => "index" )
  end

  private 

    def account_params
      # TODO: restirct user_id param field by form
      params.require(:account).permit(:name, :user_id, :balance, :account_number, :description)
    end
end
