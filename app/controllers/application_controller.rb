class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale

 
  def not_authenticated
    redirect_back_or_to :root_path, :warning => t('application.no_access')
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_back_or_to root_path, :warning => exception.message
  end

  def set_locale
      extracted_locale = params[:locale] ||
                         extract_locale_from_accept_language_header ||
                         extract_locale_from_tld ||
                         extract_locale_from_subdomain ||
                         I18n.default_locale

      I18n.locale = extracted_locale.to_sym
      #I18n.locale =  params[:locale] ||  I18n.default_locale
    end

    #extract the locale from domain name
    def extract_locale_from_tld
      parsed_locale = request.host.split('.').last
      
    end
    #extract the locale from subdomain
    def extract_locale_from_subdomain
      parsed_locale = request.subdomains.first
      
    end

    #extract the locale from browser
    def extract_locale_from_accept_language_header
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end

    # app/controllers/application_controller.rb
    def default_url_options(options = {})
      { locale: I18n.locale }.merge options
    end

end
