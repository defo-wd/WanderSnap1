class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @post.maps.build
  end

  def create
    @post = current_user.posts.new(post_params)
        # MapのIDがparamsに存在する場合は、そのMapオブジェクトを@postのmapに設定
      if @post.save
        # 緯度と経度を関連するMapオブジェクトにも保存する(仮定)
        @post.maps.create(latitude: params[:post][:latitude], longitude: params[:post][:longitude])
        redirect_to @post, notice: 'Post was successfully created.'
      else
        render :new
      end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  def post_params
    params.require(:post).permit(:body, :snap, maps_attributes: [:id, :latitude, :longitude, :spot_name, :description, :photo_url, :_destroy])
  end

end
