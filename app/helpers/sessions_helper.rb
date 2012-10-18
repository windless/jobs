module SessionsHelper
  def signed_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= User.find_by_remember_token(session[:remember_token])
  end

  def current_user=(user)
    @current_user = user
  end

  def sign_in(user)
    session[:remember_token] = user.remember_token
    current_user = user
  end

  def sign_out
    session.delete :remember_token
    cookies.delete :remember_token
    current_user = nil
  end
end
