class TransactionsController < ApplicationController
  def deposit_new
    @transaction = Transaction.new
  end

  def deposit_create
    @transaction = Transaction.new(transaction_params)
    @transaction.type_of_transaction = "Depósito"
    @transaction.account = Account.find(session[:user_id]) if session[:user_id]

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

  def withdrawal_new
    @transaction = Transaction.new
  end

  def withdrawal_create
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

  def transference_new
    @transaction = Transaction.new
  end

  def transference_create
    @transaction = Transaction.new(transaction_params)
    @transaction.type_of_transaction = "Transferência"
    @transaction.account = Account.find(session[:user_id])

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

  def receipt
    @transaction = Transaction.find(params[:id])
  end

  def check_balance
    @account = Account.find(session[:user_id])
  end

  def statement_new
    @transaction = Transaction.new
  end

  def statement_receipt
    user = Account.find(session[:user_id])
    date_from = Date.new params["date_from(1i)"].to_i, params["date_from(2i)"].to_i, params["date_from(3i)"].to_i
    date_to = Date.new params["date_to(1i)"].to_i, params["date_to(2i)"].to_i, params["date_to(3i)"].to_i
    @statement = Transaction.where(:created_at => date_from.beginning_of_day..date_to.end_of_day).where(:account_id => user.id)
  end

private
  def transaction_params
    params.require(:transaction).permit!
  end
end
