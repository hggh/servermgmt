# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  MAX_SESSION_PERIOD = 3600
  @current_user = nil
  @ajax_request = nil
  @ajax_from = nil


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
  before_filter :ajax_request?

  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def render_404
    render :template => "common/404", :layout => 'error', :status => 404
    return false
  end


  def ajax_request?
    @ajax_request = true if request.xhr?
    @ajax_from = params[:ajax_from] if params[:ajax_from]
  end

  def login_required
    if params[:secret_key] and params[:secret_key].size > 10
      u = User.find_by_secret_key(params[:secret_key])
      if u and u.active == 1 and u.secret_key.size > 10
        return true
      end
    end
    if session[:user] and User.cookie_checkauth(session[:user])
      @current_user = User.cookie_checkauth(session[:user])
      return true
    end
    if cookies[:login] and User.cookie_checkauth(cookies[:login])
      @current_user = User.cookie_checkauth(cookies[:login])
      return true
    end
    session[:return_to]=request.fullpath
    redirect_to :controller => "user_login", :action => 'login'
    return false 
  end
  
  def session_expiry
    reset_session if session[:expiry_time] and session[:expiry_time] < Time.now

    session[:expiry_time] = MAX_SESSION_PERIOD.seconds.from_now
    return true
end

end
