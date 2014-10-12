class TransactionsController < ApplicationController
  layout false
  def index
    @transactions = Transaction.sorted
  end

  def show
    @transaction = Transaction.find_by_id(params[:id])
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      flash[:notice] = "transaction ##{@transaction.id} created successfully."
      redirect_to( :action => "index" )
    else
      render("new")
    end
  end

  def edit
    @transaction = Transaction.find_by_id(params[:id])
  end

  def update
    @transaction = Transaction.find_by_id(params[:id])
    if @transaction.update_attributes(transaction_params)
      flash[:notice] = "transaction ##{@transaction.id} updated successfully."
      redirect_to( :action => "show", :id => @transaction.id )
    else
      render("new")
    end
  end

  def destroy
    transaction = Transaction.find_by_id(params[:id]).destroy
    flash[:notice] = "transaction ##{transaction.id} deleted successfully."
    redirect_to( :action => "index" )
  end

  private 

    def transaction_params
      # TODO: restirct account_id param field by form
      params.require(:transaction).permit(:account_id, :cashFlow, :note)
    end
end
