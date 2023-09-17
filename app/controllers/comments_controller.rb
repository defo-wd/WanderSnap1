class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :find_post, only: [:create, :destroy]

  def index
    @comments = Comment.all
  end

 def create
  @comment = @post.comments.new(comment_params.merge(user_id: current_user.id))
  if @comment.save
    respond_to do |format|
      format.html { redirect_to @post, notice: 'Comment was successfully created.' }
      format.js
    end
  else
    redirect_to @post
  end
 end

def destroy
  @comment = @post.comments.find_by(id: params[:id], user_id: current_user.id)
  if @comment&.destroy
    respond_to do |format|
      format.html { redirect_to @post, notice: 'Comment was successfully destroyed.' }
      format.js
    end
  else
    redirect_to @post, alert: 'Failed to destroy the comment.'
  end
end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end


