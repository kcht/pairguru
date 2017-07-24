class CommentsController < ApplicationController
  include CommentsHelper

  before_action :authenticate_user!, only: [:new, :create, :destroy]

  expose(:movie)
  expose(:comments) { movie.comments }
  expose(:comment)

  def new
    @comment = Comment.new(movie_id: params[:movie_id])
  end

  def create
    @movie = Movie.find(params[:comment][:movie_id])
    unless current_user_comment(@movie)
      begin
        @comment = Comment.create!(comment_params.merge(user_id: current_user.id))
        flash[:notice] = "Successfully created comment"
      rescue => e
        flash[:error] = "Please correct errors in your comment: #{e.message}"
      end
    end
    redirect_to @movie
  end

  def destroy
    flash[:notice] = if Comment.find(params[:id]).destroy
                       "Successfully deleted comment"
                     else
                       "Somethign went wrong. Didn't delete comment"
                     end
    redirect_back fallback_location: root_path
  end

  def top_commenters
    @top_commenters = User.top_commenters_from_last_week
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :content, :movie_id)
  end
end
