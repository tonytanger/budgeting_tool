class AccountsController < ApplicationController

  def index
    checkUserStatus
    @accounts = Account.sorted
  end

  def show
    if checkUserStatus
      if params.has_key?(:id)
        @account = Account.find_by_id(params[:id])
        @user = User.find_by_id(session[:current_user_id])
        if @account.user_id != @user.id
          # user try to access an account that doesn't belong to them
          redirect_to(:controller => :users, :action => :sign_out)
        end
        @transactions = Transaction.where(account_id: "#{@account.id}")
      else 
        @account = Account.new
      end
    end
  end

  def new
    checkUserStatus
    @account = Account.new()
  end

  def create
    if checkUserStatus
      @account = Account.new(account_params)
      @account.user_id = session[:current_user_id]

      if @account.save
        flash[:notice] = "Account #{@account.name} created successfully."
        redirect_to( :action => "index" )
      else
        render("new")
      end
    end
  end

  def edit
    checkUserStatus
    @account = Account.find_by_id(params[:id])
  end

  def update
    checkUserStatus
    @account = Account.find_by_id(params[:id])
    if @account.update_attributes(account_params)
      flash[:notice] = "Account #{@account.name} updated successfully."
      redirect_to( :action => "show", :id => @account.id )
    else
      render("new")
    end
  end

  def destroy
    checkUserStatus
    account = Account.find_by_id(params[:id]).destroy
    flash[:notice] = "Account #{account.name} deleted successfully."
    redirect_to( :action => "index" )
  end

  private 

    def account_params
      # TODO: restirct user_id param field by form
      params.require(:account).permit(:name, :user_id, :balance, :account_number, :description)
    end

    def checkUserStatus
      if !session[:current_user_id]
        redirect_to(:controller => "users", :action => "index")
        false
      end
      true
    end
end
