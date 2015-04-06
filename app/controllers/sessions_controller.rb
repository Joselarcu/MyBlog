class SessionsController < ApplicationController
  def new
  end

  def create
    user = login(params[:username],params[:password],params[:remember_me])
    if user
      redirect_to root_url, :success => t('session.message.logedin')
    else
      flash.now.alert = t('session.message.invalid_email')
      render 'new'
    end
  end

  def destroy
    logout
    redirect_back_or_to root_url, :info => t('session.message.logedout')
  end
end
