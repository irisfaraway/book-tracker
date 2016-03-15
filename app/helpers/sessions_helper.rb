module SessionsHelper

  # Returns the user who is currently logged in
  def current_user
    @current_user ||=User.find_by(id: session[:user_id])
  end

  # Checks if anyone is logged in or not
  def logged_in?
    !current_user.nil?
  end
end