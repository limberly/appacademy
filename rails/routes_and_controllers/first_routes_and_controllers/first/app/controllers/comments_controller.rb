class CommentsController < ApplicationController
  def index
    user = params[:user_id]
    art = params[:artwork_id]
    if user.is_a?(String)
      comments = Comment.where(user_id: user)
    elsif art.is_a?(String)
      comments = Comment.where(artwork_id: art)  
    else
      comments = Comment.all
    end
    
    render json: comments
  end

  private
  def comment_params
      params[:comment].permit(:body, :user_id, :artwork_id)
  end
end