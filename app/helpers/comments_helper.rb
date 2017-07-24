module CommentsHelper
  def formatted_comment_datetime(datetime)
    datetime.nil? ? nil : datetime.strftime("%d %B %Y at %H:%M")
  end

  def can_user_comment_movie?(movie)
    current_user_comment(movie).nil?
  end

  def current_user_comment(movie)
    movie.comments.where(user_id: current_user.id).first
  end
end