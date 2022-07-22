class WithdrawalController < ApplicationController
  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.type_of_transaction = "Saque"
    @transaction.account = Account.find(session[:user_id])
    @transaction.destination = ""
    if @transaction.save
      client = Account.find(@transaction.account_id)
      if client && client.balance.to_f >= @transaction.amount.to_f
        client.balance -= @transaction.amount.to_f
        client.save
        redirect_to transaction_receipt_path(@transaction), notice: "Saque realizado com sucesso"
      else
        redirect_to withdrawal_path, status: :unprocessable_entity, alert: "Saldo insuficiente para este saque!"
      end
    else
      redirect_to withdrawal_path, status: :unprocessable_entity, alert: "Não foi possível realizar sua transação!"
    end

  end
end
