class SessionsController < ApplicationController
  def new
  end

  def create
    account = Account.find_by(email: params[:email])
    if account && account.active == true && account.authenticate(params[:password])
      session[:user_id] = account.id
      redirect_to root_path
    elsif account && account.active == false && account.authenticate(params[:password])
      flash.now[:alert] = "Sua conta está desativada! Use outro e-mail ou entre em contato com a nossa equipe."
      render :new, status: :unprocessable_entity
    else
      flash.now[:alert] = "Senha ou email incorretos!"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, status: :see_other, notice: "Logout realizado com sucesso!"
  end
end
