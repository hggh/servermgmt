class UserLoginController < ApplicationController
  skip_before_filter :login_required, :only => [ 'login', 'trylogin', 'logout' ]
  def login
    @user = User.new
    respond_to do |format|
      format.html
    end
  end
  
  def logout
    flash[:notice] = "Logged off."
    reset_session
    cookies.delete :login
    redirect_to(:controller => 'home')
  end
  
  def trylogin
    @user = User.authenticate(params[:user][:username],params[:user][:passwd]  )
    if @user.nil?
      @user = User.new
      flash[:error]='Username or Password wrong!'
      respond_to do |format|
        format.html { render :action => "login" }
      end
    else
      flash[:notice]  = "Login successful"
      if session[:return_to]
        session[:user] = @user.cookie_remember
        cookies[:login] = { :value => @user.cookie_remember, :expires => 1.week.from_now }
        redirect_to(session[:return_to])
      else
        redirect_to(:controller => 'home')
      end
    end  
  end
end
