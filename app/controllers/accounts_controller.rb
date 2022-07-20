class AccountsController < ApplicationController
  def index
    @accounts = Account.all
  end

  def show
    @account = Account.find(params[:id])
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)
    @account.save
    if @account.save
      session[:user_id] = @account.id
      redirect_to root_path, notice: "Conta criada com sucesso, você agora faz parte do Time Nobe!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    if @account.update(account_params)
      redirect_to root_path, notice: "Informações atualizadas com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @account = Account.find(params[:id])
    @account.active = false
    @account.save
    session[:user_id] = nil
    redirect_to root_path, alert: "Conta desativada!", status: :see_other
  end

private

  def account_params
    params.require(:account).permit(:name, :email, :password, :password_confirmation)
  end

end
