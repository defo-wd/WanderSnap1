class HomesController < ApplicationController
  def top
    @posts = Post.all
    @post = Post.new
    @maps = Map.includes(:post_maps => :post).all
  end
end
