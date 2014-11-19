class UsersController < ApplicationController
 before_action :get_user, only: [ :show, :edit, :update ]
 before_action :admin_user, only: [:index]
 load_and_authorize_resource :only => [ :show ] 
 before_action :user_is_current_user, :only => [:show, :update, :edit]
  
  def index
    authorize! :index, current_user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path,  :info => "Signed up!"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def get_user
    @user = User.find(params[:id])
  end

  def admin_user
    if !(current_user != nil  && (current_user.has_role? :admin))
      redirect_to root_path, :warning => 'Not authorized as an administrator.'
    end
  end

  def user_is_current_user
    if current_user == nil 
      redirect_to root_path, :info => 'You mus to login'
      elsif current_user.id != @user.id
        redirect_to root_path, :info => 'You are not authorized'
    end
  end
end
