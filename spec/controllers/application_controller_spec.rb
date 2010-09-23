require 'spec_helper'

describe ApplicationController do

  before(:all) do
    controller.stub!(:get_token)
  end

  context 'client token' do
    it 'has a facebook client' do
      client = controller.send(:client)
      client.should be_kind_of(OAuth2::Client)
    end

    it 'should ensure that the correct client keys are set in the oauth2 client' do
      client = controller.send(:client)
      client.id.should == "157960757563750"
    end

    it 'should ensure that the correct secret is set in the oauth2 client' do
      client = controller.send(:client)
      client.should be_kind_of(OAuth2::Client)
      client.secret.should == "f2579fe22c480eaf339a0039dd5f4e0e"
    end


    it 'has a facebook access token' do
      lambda { 
        controller.send :token
      }.should raise_exception(OAuth2::HTTPError)
    end

    it 'can make a get request using the token' do
      return pending '- I have disabled this method as too many fb calls seemed to make FB stop communicating'
      lambda { 
        controller.send :token_get, "foo"
      }.should raise_exception(OAuth2::HTTPError)
    end


    it 'has a default callback for the token' do
      call_back = controller.send :default_callback
      call_back.should == "http://strong-water-21.heroku.com/"
    end

  end

  context 'session key management' do
    it 'can detect a facebook callback' do
      controller.params[:code] = "pow"
      controller.should_receive(:set_app_session).with('pow').once
      controller.send :detect_fb_code_callback
    end

    context 'getting, setting and changing the session key after we already have one' do

      def session_key
        controller.session[:app_session]
      end

      before(:each) do
        controller.send(:set_app_session, "pow")
      end

      it 'can set the app session key' do
        session_key.should == "pow"
      end

      it 'will not set the app session key if attempting to set to a nil object' do
        controller.send(:set_app_session, nil)
        session_key.should == "pow"
      end

      it 'retrieve the app session key' do
        session_key.should == "pow"
      end

      it 'can clear the app session key' do
        controller.send(:clear_app_key!)
        session_key.should be_nil
      end

      it 'can tell if the app session key has been set' do
        controller.send(:app_session_key?).should be_true
      end

      it 'can tell if the current user is logged in or not.' do
        controller.send(:logged_in?).should be_true
      end
    end
  end


end
