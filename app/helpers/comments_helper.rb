module CommentsHelper
  def formatted_comment_datetime(datetime)
    datetime.nil? ? nil : datetime.strftime("%d %B %Y at %H:%M")
  end
end