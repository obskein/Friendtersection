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
end
