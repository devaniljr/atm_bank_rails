class DepositController < ApplicationController
  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.type_of_transaction = "Depósito"
    @transaction.account = current_user

    if @transaction.save
      destination = Account.find_by(email: @transaction.destination)
      if destination
        destination.balance += @transaction.amount.to_f
        destination.save
        redirect_to transaction_receipt_path(@transaction), notice: "Depósito realizado com sucesso"
      else
        redirect_to deposit_path, status: :unprocessable_entity, alert: "Não encontramos essa conta!"
      end
    else
      redirect_to deposit_path, status: :unprocessable_entity, alert: "Não foi possível realizar sua transação!"
    end
  end
end
