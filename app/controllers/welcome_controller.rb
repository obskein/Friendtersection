
class WelcomeController < ApplicationController

  before_filter :detect_fb_code_callback, :only => :index

  # TODO :: Consider doing less at once or fragment 
  # caching to avoid unecessary API calls
  def index
    if logged_in?
      @friend_id = params[:friend_id]

      @user = facebook_data_about '/me'
      @likes = facebook_data_about '/me/likes', :as => "data"
      @friends = facebook_data_about '/me/friends', :as => "data"

      if @friend_id
        @friend_id = params[:friend_id]
        @friend = facebook_data_about "/#{@friend_id}"
        @friends_likes = facebook_data_about "/#{@friend_id}/likes", :as => "data"
      end

      if @friends_likes
        @intersection = intersection_of(@likes, @friends_likes)
      end
    end
  end

  private

  # Lookup method used to retrieve data from facebook.
  # TODO :: Move to model methods.
  # TODO :: cache token.get requests
  def facebook_data_about(item, keys = {})
    begin
      res = JSON.parse(token_get(item) || "{}") 
      keys[:as] ? res[keys[:as]] : res
    rescue SocketError, Errno::ECONNRESET, OAuth2::HTTPError, EOFError => e
      # TODO :: hoptoad
      nil
    end
  end

  # Helper method compares hashes based on id values.
  # TODO :: move to extensions, and probably subclass 
  # array or hash if more widely used
  def intersection_of left, right
    # Using sorts may be more efficient on large sets.
    right.inject([]) { |intersect, r|
      # The select could be made more efficient.
      matches = left.select { |l| l["id"] == r["id"] }
      intersect.push(matches.first) if matches.any?
      intersect
    }
  end
end
