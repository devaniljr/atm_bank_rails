class TransactionsController < ApplicationController
  def receipt
    @transaction = Transaction.find(params[:id])
  end

  def check_balance
    @account = current_user
  end
end
