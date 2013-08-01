class SessionsController < ApplicationController

  def new
  end

  def create
  	user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user, notice: 'Bienvenido.'
    else
      flash.now[:error] = 'Combinación email/password invalida'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url, notice: 'Tu sesion se ha cerrado correctamente, regresa pronto.'
  end
end
