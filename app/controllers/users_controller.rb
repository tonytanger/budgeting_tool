class UsersController < ApplicationController

  before_action :confirmed_signed_in, except: [:sign_in, :attempt_sign_in, :sign_out, :new, :create]
  before_action :already_signed_in, only: [:sign_in, :attempt_sign_in, :new, :create]

  # Sign In Page
  # /users/signin
  def sign_in
    render("signin")
  end

  # attempt to sing in user, if successful redirect, if not redirect to sign in page
  def attempt_sign_in
    # did the user fill in the email and password form field?
    if params[:email].present? and params[:password].present?
      found_user = User.where(email: params[:email]).first
      # does the email exist in the database?
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end
    # does found_user has the correct password?
    if authorized_user
      session[:current_user_id] = authorized_user.id
      session[:current_user_email] = authorized_user.email
      flash[:success] = "Successfully Signed In."
      redirect_to(controller: "accounts", action: "index")
    else
      # invalid email/password combination
      flash[:error] = "Invalid email/password combination."
      redirect_to(action: "sign_in")
    end
  end

  # sign out user, destroy user session
  def sign_out
    session[:current_user_id] = nil
    session[:current_user_email] = nil
    flash[:success] = "Successfully Signed out"
    # should redirect to "Home Page", currently user#index
    redirect_to(controller: "users", action: "index")
  end

  # display single User
  # /users/show/:id
  def show
    if session[:current_user_id]
      @user = User.find_by_id(session[:current_user_id]) # what is find_by_id returns nil?
      if @user
        @accounts = Account.where(user_id: "#{@user.id}")
      else
        redirect_to(action: :sign_out)
        return
      end
    else
      @user = User.find_by_id(params[:id])
    end
  end

  # display new User
  # /users/new
  def new
    @user = User.new()
  end

  # create User
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "User '#{@user.email}' created successfully!"
      redirect_to( action: :index )
      return
    else
      render('new')
    end
  end

  # display edit User
  # /users/edit/:id
  def edit
    @user = User.find_by_id(session[:current_user_id])
  end

  # update User
  def update
    @user = User.find_by_id(params[:id])

    if @user.update_attributes(user_params)
      flash[:notice] = "User '#{@user.email}' updated successfully!"
      redirect_to( action: 'show', id: @user.id )
      return
    else
      render('edit')
    end
  end

  # destry User
  def destroy
    user = User.find_by_id(params[:id]).destroy
    flash[:notice] = "User '#{user.email}' deleted successfully!"
    redirect_to( action: "index")
  end


  private

    # this requires user to be instantiated
    # this also allows the fields to be mass assigned
    def user_params
      params.require(:user).permit(:email, :password, :email, :first_name, :last_name)
    end

    def already_signed_in
      if session[:current_user_id]
        redirect_to(controller: "users", action: "show")
        return false
      else
        return true
      end
    end
end
