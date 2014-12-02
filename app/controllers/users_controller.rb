class UsersController < ApplicationController
 before_action :get_user, only: [ :show, :edit, :update, :destroy ]
 before_action :admin_user, only: [:index]
 load_and_authorize_resource :only => [ :show ] 
 before_action :user_is_current_user_or_admin, :only => [:show, :update, :edit, :destroy]
  
  def index
    authorize! :index, current_user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def show
  end

  def new
    if current_user != nil 
      redirect_back_or_to root_path, :info => 'You are already registered'
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
     if @user.save
       login(user_params[:username], user_params[:password], true)
       redirect_back_or_to root_path,  :info => "Signed up successfully!"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      if current_user.has_role? :admin
        redirect_back_or_to users_path, :success => "User updated successfully"
      else
        redirect_back_or_to user_path(@user), :success => "User updated successfully"
      end
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    if current_user.has_role? :admin
      redirect_back_or_to users_path, :success => "User deleted succesfully"
    else
      redirect_back_or_to root_path, :success => "User deleted succesfully"
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :name, :surname, :email, :password, :password_confirmation)
  end

  def get_user
    @user = User.find(params[:id])
  end

  def admin_user
    if !(current_user != nil  && (current_user.has_role? :admin))
      redirect_back_or_to root_path, :warning => 'Not authorized as an administrator.'
    end
  end

  def user_is_current_user_or_admin
    if current_user == nil 
      redirect_back_or_to root_path, :info => 'You mus to login'
    elsif current_user.id != @user.id && !(current_user.has_role? :admin)
      redirect_back_or_to root_path, :info => 'You are not authorized'
    end
  end
end
