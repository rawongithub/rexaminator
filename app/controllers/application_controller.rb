class ApplicationController < ActionController::Base

  if Rails.env == 'test'
    ADMIN_LOGIN        = "admin"
    ADMIN_PASSWORD     = "e5e9fa1ba31ecd1ae84f75caaa474f3a663f05f4"
  else
    ADMIN_LOGIN        = "admin"
    ADMIN_PASSWORD     = "e5e9fa1ba31ecd1ae84f75caaa474f3a663f05f4"
  end

  helper :all # include all helpers, all the time

  protect_from_forgery

  protected

  def admin?
    return false unless (session[:password] && session[:login])
    (session[:password] == ADMIN_PASSWORD) && (session[:login] == ADMIN_LOGIN)
  end

  def authorize
    unless admin?
      session[:intended_action] = request.fullpath
#      render :file => "#{Rails.root}/public/404.html", :status => 404
      flash[:error] = "Error: Unauthorized Access."
      redirect_to login_path
      false
    else
      @admin = true
    end
  end

  def rescue_action(exception)
    case exception
      when ActiveRecord::RecordNotFound
        render :file => "#{Rails.root}/public/404.html", :status => 404
      else
        super
    end
  end if Rails.env == 'production'

private

  def session_expiry
    if session[:expiry_time] and session[:expiry_time] < Time.now
      reset_session
      flash[:error] = "Previous session has been expired."
      redirect_to login_url and return
    end
    session[:expiry_time] = MAX_SESSION_PERIOD.since(Time.now)
    return true
  end

end

