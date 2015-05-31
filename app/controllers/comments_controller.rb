class CommentsController < ApplicationController

  def show

  end

  def create
    @tweet= Tweet.find(params[:tweet_id])
    @comment = current_user.comments.build(comment_params)
    @comment.tweet = @tweet
    if @comment.save
      redirect_to root_path, success: '<p class="alert alert-success"> Comment posted</p>'
    else
      redirect_to root_path, danger: '<p class="alert alert-success">'+@comment.errors.full_messages.to_sentence+'</p>'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

  def comment_owner
    @tweet = current_user.comment.find_by(id: params[:id])
  end
end
