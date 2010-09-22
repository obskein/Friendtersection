class LoginController < ApplicationController

  def create
    redirect_to client.web_server.authorize_url( :redirect_uri => default_callback, :scope => 'friends_likes')
  end

  def destroy
    clear_app_key!
    redirect_to root_path
  end
end
