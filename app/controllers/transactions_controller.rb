class TransactionsController < ApplicationController

  def index
    checkUserStatus
    @transactions = Transaction.sorted
  end

  def show
    checkUserStatus
    @transaction = Transaction.find_by_id(params[:id])
  end

  def new
    checkUserStatus
    if params[:account_id]
      @transaction = Transaction.new
      @transaction.account_id = params[:account_id]
    else
      flash[:error] = "Missing account id, please try again!"
      redirect_to(:controller => :accounts, :action => :index)
    end
  end

  def create
    checkUserStatus
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      flash[:success] = "transaction ##{@transaction.id} created successfully."
      redirect_to( :action => "index" )
    else
      render("new")
    end
  end

  def edit
    checkUserStatus
    @transaction = Transaction.find_by_id(params[:id])
  end

  def update
    checkUserStatus
    @transaction = Transaction.find_by_id(params[:id])
    # BUG: check transaction.account_id.user_id is current_user_id
    if @transaction.update_attributes(transaction_params)
      flash[:success] = "transaction ##{@transaction.id} updated successfully."
      redirect_to( :action => "show", :id => @transaction.id )
    else
      render("new")
    end
  end

  def destroy
    checkUserStatus
    transaction = Transaction.find_by_id(params[:id]).destroy
    flash[:success] = "transaction ##{transaction.id} deleted successfully."
    redirect_to( :action => "index" )
  end

  private

    def transaction_params
      # TODO: restirct account_id param field by form
      params.require(:transaction).permit(:account_id, :cash_flow, :note, :receiptDate)
    end

    def checkUserStatus
      if !session[:current_user_id]
        redirect_to(:controller => "users", :action => "index")
      end
    end
end
