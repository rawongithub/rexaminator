class SessionsController < ApplicationController

  before_filter :session_expiry, :except => [:new, :create]

  def new

  end

  def create
    session[:login] = params[:login]
    session[:password] = Digest::SHA1.hexdigest(params[:password])
    flash[:notice] = "Successfully logged in"
    if (redirect_uri = session[:intended_action])
      redirect_to redirect_uri
      session[:intended_action] = nil
    else
      redirect_to admin_path
    end
  end

  def destroy
    reset_session
    flash[:notice] = "Successfully logged out"
    redirect_to login_path
  end

end

