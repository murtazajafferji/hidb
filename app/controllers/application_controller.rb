# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  layout 'application'
  #filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user
  
  helper :all # include all helpers, all the time
  #protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  before_filter :instantiate_controller_and_action_names
  before_filter :set_locale
  before_filter :email_defaults
  
  #LOCALES = {"en" => I18n.t("English"), "zh" => I18n.t("Chinese")}
  LOCALES = {"en" => I18n.t("English")}
   
  def set_locale
    # if params[:locale] is nil then I18n.default_locale will be used
    I18n.locale = params[:locale]
  end

  def instantiate_controller_and_action_names
    @current_action = action_name
    @current_controller = controller_name
  end
  
  def redirect_back_or(path)
    redirect_to :back
    rescue ActionController::RedirectBackError
    redirect_to path
  end
  
  def email_defaults
    Pony.options = {
      :from => "#{SITE_NAME} <#{SITE_EMAIL}>", 
      :via => :smtp, 
      :via_options => {
        :address              => 'smtp.gmail.com',
        :port                 => '587',
        :enable_starttls_auto => true,
        :user_name            => SITE_EMAIL,
        :password             => 'temporary',
        :authentication       => :plain # :plain, :login, :cram_md5, no auth by default
        #:domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
      } 
    }
  end
  
  def login_required
    if current_user.nil?
      redirect_to new_user_url
      true
    end
    false
  end

private
  def admin_only
    if Rails.env == "production"
      authenticate_or_request_with_http_basic do |id, password|
        id == ENV["USER"] && password == ENV["PASSWORD"]
      end
    end
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      #flash[:notice] = "You must be logged out to access this page"
      #redirect_to profile_url(current_user)
      redirect_to internships_path
      return false
    end
  end
  
  def require_admin
    unless current_user.admin
      store_location
      flash[:notice] = "You must be admin in to access this page"
      redirect_to internships_path
      return false
    end
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
  # uncomment this for persistent locale
  #def default_url_options(options={})  
  #	logger.debug "default_url_options is passed options: #{options.inspect}\n"  
  #	{ :locale => I18n.locale } 
  #end 
  
end
