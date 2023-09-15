class HomesController < ApplicationController
  def top
    @posts = Post.all
    @post = Post.new
    @maps = Map.includes(:post_maps => :post).all
    @user = current_user
    @liked_posts = current_user.liked_posts if user_signed_in?
  end
end
