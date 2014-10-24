class UsersController < ApplicationController

  # log in user
  def index
    # FEATURE: add "remember me" check
    if !session[:current_user_id]
      # not logged in
      puts "Not Logged In!"
      if params.has_key?(:user) and params.has_key?(:commit)
        @user = User.find_by_email(params[:user][:email])
        if !params[:user][:password].blank? and @user and @user.password == params[:user][:password]
          # email/password combo found
          session[:current_user_id] = @user.id
          flash[:success] = "Signed In Successfully."
          redirect_to(:action => "show")
          return
        else
          # email/password combo not found
          flash[:notice] = "email/Password Combo Not Valid. Please try again!"
        end
      else
        @user = User.new 
      end
    else
      # logged in
      puts "Session: #{session[:current_user_id]}"
      @user = User.find_by_id(session[:current_user_id])
      redirect_to(:action => "show")
      return
    end

  end

  def sign_in

  end

  # attempt to sing in user, if successful redirect, if not redirect to sign in page
  def attemptSignin
    # did the user fill in the email and password form field?
    if params[:user][:email].present? and params[:user][:password].present?
      found_user = User.where(:email => params[:user][:password]).limit(1)
      if found_user
        authorized_user = found_user.authenticate(params[:user][:password])
      end
    end
    if authorized_user
      session[:current_user_id] = authorized_user.id
      session[:current_user_email] = authorized_user.email
      flash[:success] = "Successfully Signed In".
      redirect_to(:controller => "accounts", :action => "index")
    else
      flash[:error] = "Invalid email/password combination."
      redirect_to(:action => "sign_in")
    end
  end

  # sign out user, destroy user session
  def sign_out
    session[:current_user_id] = nil
    session[:current_user_email] = nil
    flash[:success] = "Successfully Signed out"
    # should redirect to "Home Page", currently user#index
    redirect_to(:controller => "use", :action => "index")
  end

  # display single User
  def show
    checkUserStatus
    if session[:current_user_id]
      @user = User.find_by_id(session[:current_user_id]) # what is find_by_id returns nil?
      if @user
        @accounts = Account.where(user_id: "#{@user.id}")
      else
        redirect_to(:action => :sign_out)
        return
      end
    else
      @user = User.find_by_id(params[:id])
    end
  end

  # display new User
  def new
    @user = User.new()
  end

  # create User
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "User '#{@user.email}' created successfully!"
      redirect_to( :action => :index )
      return
    else
      render('new')
    end
  end

  # display edit User
  def edit
    checkUserStatus
    @user = User.find_by_id(session[:current_user_id])
  end

  # update User
  def update
    checkUserStatus
    @user = User.find_by_id(params[:id])

    if @user.update_attributes(user_params)
      flash[:notice] = "User '#{@user.email}' updated successfully!"
      redirect_to( :action => 'show', :id => @user.id )
      return
    else
      render('edit')
    end
  end

  # destry User
  def destroy
    checkUserStatus
    user = User.find_by_id(params[:id]).destroy
    flash[:notice] = "User '#{user.email}' deleted successfully!"
    redirect_to( :action => "index")
  end


  private

    # this requires user to be instantiated
    # this also allows the fields to be mass assigned
    def user_params
      params.require(:user).permit(:email, :password, :email, :first_name, :last_name)
    end

    def checkUserStatus
      if !session[:current_user_id]
        redirect_to(:controller => "users", :action => "index")
        return
      end
    end
end
