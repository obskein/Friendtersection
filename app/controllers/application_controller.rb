# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper_method :logged_in?

  private

  # Oauth token retrieval
  def token(redirect_target = default_callback)
    client.web_server.get_access_token(app_session_key, :redirect_uri => redirect_target)
  end

  def token_get(path)
    # This code is disabled for automatic tests, as over use 
    # eg (autospec, autotest, ci servers, whatever)
    # will cause facebook to simply stop responding to me for ten minutes.
    # I consider that sufficiently dangerous to not even try in the test env.
    unless Rails.env == "test"
      token.get(path)
    end
  end

  # Facebook entry point
  def default_callback 
    "http://strong-water-21.heroku.com/"
  end

  # Security system
  # TODO :: Considere writing or utilising a proper user recoginition/
  # management/security system, anything at all because this is fast and dirty.

  def client
    OAuth2::Client.new('157960757563750', 'f2579fe22c480eaf339a0039dd5f4e0e', :site => 'https://graph.facebook.com')
  end

  def logged_in?
    session[:app_session]
  end

  # Pick up returning facebook calls
  # Consider this 'logged in and authorised'
  def detect_fb_code_callback
   set_app_session params[:code]
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
