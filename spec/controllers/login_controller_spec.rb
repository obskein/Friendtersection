require 'spec_helper'

describe LoginController do

  before(:all) do
    controller.stub!(:get_token)
  end

  describe 'login' do
    def login
      post :create
    end

    it 'has a create method we use to login' do
      controller.should_receive(:facebook_login_path).once.and_return("http://fake.com")
      login
      response.should redirect_to("http://fake.com")
    end

    it 'should redirect to facebook to login' do
      login
      expected_entry_point = "https://graph.facebook.com/oauth/authorize"
      expected_payload = "scope=friends_likes%2Cuser_likes&client_id=157960757563750&type=web_server&redirect_uri=http%3A%2F%2Fstrong-water-21.heroku.com%2F"
      response.should redirect_to("#{expected_entry_point}?#{expected_payload}")
    end

    context 'examination of facebook response' do
      before(:each) do
        login
        @uri = URI.parse(response.redirect_url)
        @query = HashWithIndifferentAccess.new(Hash[*@uri.query.split("&").map { |x| CGI.unescape(x).split("=") }.flatten])

      end

      it 'must have permissions requests for user_likes' do
        @query[:scope].should =~ /user_likes/
      end

      it 'must have permissions requests for friends_ikes' do
        @query[:scope].should =~ /friends_likes/
      end

      it 'must use the client id in the target' do
        @query[:client_id].should == "157960757563750"
      end

      it 'must have a callback to our host root directory' do
        @query[:redirect_uri].should == "http://strong-water-21.heroku.com/"
      end
    end

  end

  describe 'logout' do
    def logout
      delete :destroy
    end

    it 'has a destroy method we can use to logout' do
      logout
      response.should redirect_to(root_path)
    end

    it 'can be called from by getting "/logout" for manual logout' do
      route_for({ :controller => 'login', :action => 'destroy' }).should == "/logout"
    end

    it 'should clear the session path' do
      controller.should_receive(:clear_app_key!).once
      logout
    end

  end
end
