class CommentsController < ApplicationController
  def new
    @comment = Comment.new(movie_id: params[:movie_id])
  end

  def create
    @movie = Movie.find(params[:comment][:movie_id])

    @comment = Comment.find_or_initialize_by(movie_id: @movie.id, user_id: current_user.id)
    @comment.update_attributes(title: comment_params[:title], content: comment_params[:content])

    redirect_to @movie
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_back fallback_location: root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :content)
  end
end