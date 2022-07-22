class ApplicationController < ActionController::Base
  def current_user
    Account.find(session[:user_id]) if session[:user_id]
  end

  def transaction_params
    params.require(:transaction).permit!
  end
end
