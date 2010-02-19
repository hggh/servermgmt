# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  MAX_SESSION_PERIOD = 3600
  @current_user = nil


  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '7774ec5496f2d7c3eb6ff4f9e20fe699'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  layout 'default'

  before_filter :session_expiry
  before_filter :login_required
  
  filter_parameter_logging :passwd, :password, :password_confirmation
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def render_404
    render :template => "common/404", :layout => 'error', :status => 404
    return false
  end



  def login_required
    if session[:user] and User.cookie_checkauth(session[:user])
      @current_user = User.cookie_checkauth(session[:user])
      return true
    end
    if cookies[:login] and User.cookie_checkauth(cookies[:login])
      @current_user = User.cookie_checkauth(cookies[:login])
      return true
    end
    session[:return_to]=request.request_uri
    redirect_to :controller => "user_login", :action => 'login'
    return false 
  end
  
  def session_expiry
    reset_session if session[:expiry_time] and session[:expiry_time] < Time.now

    session[:expiry_time] = MAX_SESSION_PERIOD.seconds.from_now
    return true
end

end
