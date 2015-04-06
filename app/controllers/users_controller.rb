class UsersController < ApplicationController
 before_action :set_user, only: [ :show, :edit, :update, :destroy ]
 before_action :admin_user, only: [:index]
 load_and_authorize_resource :only => [ :show ] 
 before_action :user_is_current_user_or_admin, :only => [:show, :update, :edit, :destroy]
  
  def index
    authorize! :index, current_user, :message => t('user.message.no_administrator')
    @users = User.all
  end

  def show
  end

  def new
    if current_user != nil 
      redirect_back_or_to root_path, :info => t('user.message.already_registered')
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
     if @user.save
       login(user_params[:username], user_params[:password], true)
       redirect_back_or_to root_path,  :info => t('user.message.signed_up_success')
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      if current_user.has_role? :admin
        redirect_back_or_to users_path, :success => t('user.message.updated_success') 
      else
        redirect_back_or_to user_path(@user), :success => t('user.message.updated_fail')
      end
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    if current_user.has_role? :admin
      redirect_back_or_to users_path, :success => t('user.message.deleted_success')
    else
      redirect_back_or_to root_path, :success => t('user.message.deleted_fail')
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :name, :surname, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def admin_user
    if !(current_user != nil  && (current_user.has_role? :admin))
      redirect_back_or_to root_path, :warning => t('user.message.no_administrator')
    end
  end

  def user_is_current_user_or_admin
    if current_user == nil 
      redirect_back_or_to root_path, :info => t('user.message.must_login')
    elsif current_user.id != @user.id && !(current_user.has_role? :admin)
      redirect_back_or_to root_path, :info => t('user.message.no_administrator')
    end
  end
end
