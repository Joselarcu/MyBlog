class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def not_authenticated
    redirect_back_or_to :root_path, :warning => "You don't have access"
  end


  rescue_from CanCan::AccessDenied do |exception|
    redirect_back_or_to root_path, :warning => exception.message
 end
end
