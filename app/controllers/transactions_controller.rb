class TransactionsController < ApplicationController

  before_action :confirmed_signed_in

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
    else
      flash[:error] = "Missing account id, please try again!"
      redirect_to(controller: "accounts", action: "index")
    end
  end

  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      flash[:success] = "transaction ##{@transaction.id} created successfully."
      redirect_to( action: "index" )
    else
      render("new")
    end
  end

  def edit
    @transaction = Transaction.find_by_id(params[:id])
  end

  def update
    @transaction = Transaction.find_by_id(params[:id])
    # BUG: check transaction.account_id.user_id is current_user_id
    if @transaction.update_attributes(transaction_params)
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

    def transaction_params
      # TODO: restirct account_id param field by form
      params.require(:transaction).permit(:account_id, :cash_flow, :note, :receiptDate)
    end

end
