class CommentsController < ApplicationController
  def new
    @comment = Comment.new(movie_id: params[:movie_id])
  end

  def create
    @movie = Movie.find(params[:comment][:movie_id])
    redirect_to @movie
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :content)
  end
end