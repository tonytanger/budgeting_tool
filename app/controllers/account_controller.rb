class AccountController < ApplicationController

  layout false

  def index
    render "view"
  end

  def view
    @user = params[:user_id]
    @id = params[:id]
  end

end
