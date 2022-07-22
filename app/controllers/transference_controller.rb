class TransferenceController < ApplicationController
  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.type_of_transaction = "Transferência"
    @transaction.account = current_user

    if @transaction.save
      destination = Account.find_by(email: @transaction.destination)
      sender = @transaction.account
      @transaction.transference_tax = Transaction.transference_tax(@transaction.amount.to_f, Time.now)

      if destination
        if sender && destination != sender && @transaction.amount.to_f + @transaction.transference_tax <= @transaction.account.balance
          destination.balance += @transaction.amount.to_f
          sender.balance -= @transaction.amount.to_f + Transaction.transference_tax(@transaction.amount.to_f, Time.now)
          destination.save
          sender.save
          @transaction.save
          redirect_to transaction_receipt_path(@transaction), notice: "Depósito realizado com sucesso"
        else
          redirect_to transference_path, status: :unprocessable_entity, alert: "Saldo insuficiente para este saque!"
        end
      else
        redirect_to transference_path, status: :unprocessable_entity, alert: "E-mail do destinatário não encontrado!"
      end
    else
      redirect_to transference_path, status: :unprocessable_entity, alert: "Não foi possível realizar sua transação!"
    end
  end
end
