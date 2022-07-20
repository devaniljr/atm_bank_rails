module ApplicationHelper
  def current_user
    Account.find(session[:user_id]) if session[:user_id]
  end
end
