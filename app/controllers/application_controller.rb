class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  
    def confirmed_signed_in
      unless session[:current_user_id]
        # do action to show that user failed trying to access this page
        flash[:error] = "Please sign in first!"
        redirect_to(controller: "users", action: "sign_in")
        return false
      else
        return true
      end
    end
end
