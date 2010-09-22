
class WelcomeController < ApplicationController

  before_filter :detect_fb_code_callback, :only => :index

  def index
    @friend_id = params[:friend_id]
    if logged_in?

      @user = facebook_data_about '/me'
      @likes = facebook_data_about '/me/likes', :as => "data"
      @friends = facebook_data_about '/me/friends', :as => "data"


      if @friend_id
        @friend_id = params[:friend_id]
        @friend = facebook_data_about "/#{@friend_id}"
        @friends_likes = facebook_data_about "/#{@friend_id}/likes", :as => "data"
      end

      if @friends_likes
        @intersection = intersection(@likes, @friends_likes)
      end

    end
  end

  private

  def facebook_data_about(item, keys = {})
    res = JSON.parse(token.get(item) || {})
    keys[:as] ? res[keys[:as]] : res
  end

  def intersection left, right
    right.inject([]) { |intersect, r|
      matches = left.select { |l| l["id"] == r["id"] }
      intersect.push(matches.first) if matches.any?
      intersect
    }
  end
end
