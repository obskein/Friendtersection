require 'spec_helper'
describe WelcomeController do


  describe 'utility methods' do
    describe 'facebook data retrieval method' do
      before(:each) do 
        controller.stub!(:get_token)
        @res = { "data" => [ { "foo" => "bar" } ] }
        @res_json = @res.to_json
      end
      it 'can retrieve response' do
        controller.should_receive(:token_get).and_return(@res_json)
        controller.send(:facebook_data_about, 'some-resource').should == @res
      end
      it 'can retrieve data from a response' do
        controller.should_receive(:token_get).and_return(@res_json)
        controller.send(:facebook_data_about, 'some-resource', :as => "data").should == @res["data"]
      end
    end

    describe 'intersection method' do
      it 'can find the intersection of two sets of hashes' do
        left = [ { "id" => 1 }, { "id" => 2 }, { "id" => 3 } ]

        right = [ { "id" => 3 }, { "id" => 4 }, { "id" => 5 } ]

        expected_intersect = [ { "id" => 3 } ]

        controller.send(:intersection_of, left, right).should == expected_intersect
      end

    end
  end


  describe 'the index page' do
    def welcome
      get :index
    end

    context 'changing from logged in to logged out' do
      it 'is logged out by default' do
        get :index
        controller.send(:logged_in?).should be_false
      end

      it 'receives the param "code" from facebook and majestically becomes logged in' do
        get :index, :code => 'anything' 
        controller.send(:logged_in?).should be_true
      end

      it "stashes the code it gets into the app session key so that users don't have to keep reauthenticating" do
        get :index, :code => 'anything'
        session[:app_session].should == controller.send(:app_session_key)
        session[:app_session].should == 'anything'
      end

    end

    context 'logged out' do
      def assert_nil_assign(key)
        assigns[key].should be_nil
      end

      it 'should basically do nothing when not logged in' do
        welcome
        response.should render_template('welcome/index')
        assert_nil_assign(:friend_id)
        assert_nil_assign(:user)
        assert_nil_assign(:likes)
        assert_nil_assign(:friends)
        assert_nil_assign(:friend)
        assert_nil_assign(:friends_likes)
        assert_nil_assign(:intersection)
      end
    end

    context 'logged in' do
      before(:each) do
        controller.stub!(:get_token)
      end
      def welcome( payload = {})
        controller.should_receive(:logged_in?).once.and_return(true)
        get :index, payload
      end

      def assert_assign_is_mock(key, mock)
        assigns[key].should == mock
      end

      it 'should call logged in once' do
        welcome
      end

      it 'should in the best case populate user, likes and friends from facebook' do
        mock_fb_data = mock('fb-data')
        controller.should_receive(:facebook_data_about).any_number_of_times.and_return(mock_fb_data)
        welcome
        assert_assign_is_mock(:user, mock_fb_data)
        assert_assign_is_mock(:likes, mock_fb_data)
        assert_assign_is_mock(:friends, mock_fb_data)
      end

      context 'with a friend selected' do
        it 'responds to having a friend id by agressivly populating other instance fields' do
          mock_fb_data = mock('fb-data')
          controller.should_receive(:facebook_data_about).any_number_of_times.and_return(mock_fb_data)
          mock_intersection = mock('intersection')
          controller.should_receive(:intersection_of).once.with(mock_fb_data, mock_fb_data).and_return(mock_intersection)
          welcome(:friend_id => '12345')

          assert_assign_is_mock(:friend_id, '12345')
          assert_assign_is_mock(:friend, mock_fb_data)
          assert_assign_is_mock(:friends_likes, mock_fb_data)
          assert_assign_is_mock(:intersection, mock_intersection)
        end

      end
    end
  end
end

