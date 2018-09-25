class SessionsController < ApplicationController
  
  def new
    
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Bem vindo #{user.username}"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Email e/ou senha inválidos!"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Logout realizado com sucesso."
    redirect_to root_path
  end

end