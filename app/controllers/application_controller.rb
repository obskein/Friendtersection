# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper_method :logged_in?

  def token(redirect_target = default_callback)
    client.web_server.get_access_token(app_session_key, :redirect_uri => redirect_target)
  end

  def default_callback 
    "http://1000d6.com:3000/welcome"
  end

  def logged_in?
    session[:app_session]
  end

  def detect_fb_code_callback
   set_app_session params[:code]
  end

  def client
    OAuth2::Client.new('157960757563750', 'f2579fe22c480eaf339a0039dd5f4e0e', :site => 'https://graph.facebook.com')
  end

  def set_app_session key
    return if key.blank?
    session[:app_session] = key
  end

  def app_session_key
    session[:app_session]
  end

  def clear_app_key!
    session[:app_session] = nil
  end

  def app_session_key?
    !! app_session_key
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
