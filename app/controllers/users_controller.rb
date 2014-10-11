class UsersController < ApplicationController
  layout false

  # display all User
  def index
    @users = User.sorted
  end

  # display single User
  def show
    @user = User.find_by_id(params[:id])
  end

  # display new User
  def new
    @user = User.new()
  end

  # create User
  def create
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
    @user = User.find_by_id(params[:id])
  end

  # update User
  def update
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
    user = User.find_by_id(params[:id]).destroy
    flash[:notice] = "User '#{user.username}' deleted successfully!"
    redirect_to( :action => "index")
  end


  private

    # this requires user to be instantiated
    # this also allows the fields to be mass assigned
    def user_params
      params.require(:user).permit(:username, :password, :email, :first_name, :last_name)
    end

end
