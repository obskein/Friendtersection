
class WelcomeController < ApplicationController

  before_filter :detect_fb_code_callback, :only => :index

  def index
    if logged_in?

      @user = JSON.parse(token.get('/me'))
      @likes = JSON.parse(token.get('/me/likes') || {})["data"]
      @friends = JSON.parse(token.get('/me/friends') || {})["data"]


      if params[:friend_id]
        @friend_id = params[:friend_id]
        @friends_likes = JSON.parse(token.get("/#{@friend_id}/likes") || {})["data"] if @friend_id
      end

      if @friends_likes
        @random_likes = (0..rand(5)).to_a.map { @friends_likes.rand }
        @intersection = @likes & @friends_likes
      end

    end
  end
end
