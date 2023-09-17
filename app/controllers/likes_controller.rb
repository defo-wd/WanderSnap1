class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    like = current_user.likes.new(post_id: @post.id)
    respond_to do |format|
      if like.save
        format.html { redirect_to post_path(@post) }
        format.js
      else
        format.html { redirect_to post_path(@post), notice: "Something went wrong" }
        format.js { render :error }
      end
    end
    render :fav
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: @post.id)
    respond_to do |format|
      if like&.destroy
        format.html { redirect_to post_path(@post) }
        format.js
      else
        format.html { redirect_to post_path(@post), notice: "Something went wrong" }
        format.js { render :error }
      end
    end
    render :fav
  end
end
