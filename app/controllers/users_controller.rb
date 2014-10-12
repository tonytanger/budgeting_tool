class UsersController < ApplicationController

  # display all User
  def index
    # OLD:
    # @users = User.sorted
    # 
    
    # FEATURE: add "remember me" check
    if !session[:current_user_id]
      if params.has_key?(:user) and params.has_key?(:commit)
        @user = User.find_by_username(params[:user][:username])
        puts "password: #{params[:user][:password]}"
        if !params[:user][:password].blank? and @user.password == params[:user][:password]
          # username/password combo found
          session[:current_user_id] = @user.id
          flash[:success] = "Signed In Successfully."
          redirect_to(:action => "show")
        else
          # username/password combo not found
          flash[:notice] = "Username/Password Combo Not Valid. Please try again!"
        end
      else
        @user = User.new 
      end
    elsif session[:current_user_id]
      @user = User.find_by_id(session[:current_user_id])
      redirect_to(:action => "show")
    end

  end

  # display single User
  def show
    checkUserStatus
    if session[:current_user_id]
      @user = User.find_by_id(session[:current_user_id])
      @accounts = Account.where(user_id: "#{@user.id}")
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
    checkUserStatus
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "User '#{@user.username}' created successfully!"
      redirect_to( :action => 'index' )
    else
      render('new')
    end
  end

  # display edit User
  def edit
    checkUserStatus
    @user = User.find_by_id(params[:id])
  end

  # update User
  def update
    checkUserStatus
    @user = User.find_by_id(params[:id])

    if @user.update_attributes(user_params)
      flash[:notice] = "User '#{@user.username}' updated successfully!"
      redirect_to( :action => 'show', :id => @user.id )
    else
      render('edit')
    end
  end

  # destry User
  def destroy
    checkUserStatus
    user = User.find_by_id(params[:id]).destroy
    flash[:notice] = "User '#{user.username}' deleted successfully!"
    redirect_to( :action => "index")
  end

  def sign_out
    checkUserStatus
    session[:current_user_id] = nil
    flash[:success] = "Successfully Signed out"
    redirect_to( :action => "index")
  end

  private

    # this requires user to be instantiated
    # this also allows the fields to be mass assigned
    def user_params
      params.require(:user).permit(:username, :password, :email, :firstName, :lastName)
    end

    def checkUserStatus
      if !session[:current_user_id]
        redirect_to(:controller => "users", :action => "index")
      end
    end
end
