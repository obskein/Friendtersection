class LoginController < ApplicationController

  # Hand the user off to facebook to authenticate.
  # A filter captures the code and attempts to use it on subsequent 
  # requests.
  def create
    redirect_to facebook_login_path
  end

  # Logout by clearing the session information. Additionally, 
  # made accessible to get requests to facilitate 
  # manual logout.
  # TODO :: consider notifying facebook
  def destroy
    clear_app_key!
    redirect_to root_path
  end

  private
  # Generate a path from
  def facebook_login_path
    payload = { :redirect_uri => default_callback, :scope => 'friends_likes,user_likes' }
    client.web_server.authorize_url( payload )
  end
end
