class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :find_post, only: [:create, :destroy]

  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.new(comment_params.merge(user_id: current_user.id))
    if @comment.save
      redirect_to @post, notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @comment = @post.comments.find_by(id: params[:id], user_id: current_user.id)
    if @comment&.destroy
      redirect_to @post, notice: 'Comment was successfully destroyed.'
    else
      redirect_to @post, alert: 'Failed to destroy the comment.'
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
