class StatementController < ApplicationController
  def new
    @transaction = Transaction.new
  end

  def receipt
    user = Account.find(session[:user_id])
    date_from = Date.new params["date_from(1i)"].to_i, params["date_from(2i)"].to_i, params["date_from(3i)"].to_i
    date_to = Date.new params["date_to(1i)"].to_i, params["date_to(2i)"].to_i, params["date_to(3i)"].to_i
    @statement = Transaction.where(:created_at => date_from.beginning_of_day..date_to.end_of_day).where(:account_id => user.id)
  end
end
