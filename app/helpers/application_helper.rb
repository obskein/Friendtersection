# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def render_likes likes
    content_tag :ul do
      likes.map { |like|
        created_at = Time.parse(like["created_time"]).to_s(:short)
        category = like["category"].to_s.gsub("_", " ").gsub("other", "(other)")
        name = like["name"]
        content = "#{name}, #{category}, created at #{created_at}"
        content_tag :li, content
      }
    end
  end

  def render_user user
    content_tag :dl do
      user.keys.sort.map { |key|
        value = h(user[key])
        value = Time.parse(value) if key =~ /time/
        content_tag( :dt, key.to_s.humanize ) + 
          content_tag( :dd, value ) }
    end
  end
end
