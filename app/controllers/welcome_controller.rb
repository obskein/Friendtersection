
class WelcomeController < ApplicationController
  def client
    OAuth2::Client.new('157960757563750', 'f2579fe22c480eaf339a0039dd5f4e0e', :site => 'https://graph.facebook.com')
  end

  def index
  end

  def create
    redirect_to client.web_server.authorize_url( :redirect_uri => "http://1000d6.com/fb")#, :scope => 'email,offline_access')
  end

end
