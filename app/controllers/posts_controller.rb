class PostsController < ApplicationController
 before_action :authenticate_user!, only: [:edit, :update, :destroy]
 before_action :correct_user, only: [:edit, :update, :destroy]
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.where(parent_id: nil).includes(:replies) # 主コメントとそのリプライを取得
    @comment = @post.comments.new
  end

  def new
    @post = Post.new
    @post.maps.build
  end

  def create
    @post = current_user.posts.new(post_params)
        # MapのIDがparamsに存在する場合は、そのMapオブジェクトを@postのmapに設定
      if @post.save
         @map = Map.new(map_params)
         @map.post_id = @post.id
         @map.save!
         @post_map = PostMap.new(post_id:@post.id,map_id:@map.id)
         @post_map.save!
         latitude = params[:map][:latitude]
         longitude = params[:map][:longitude]
        # 緯度と経度を関連するMapオブジェクトにも保存する(仮定)
        #@post.maps.create(latitude: params[:post][:latitude], longitude: params[:post][:longitude])
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

  def search
  @q = Post.ransack(params[:q])
  @posts = @q.result(distinct: true)
  end

  private
   def correct_user
       @post = Post.find(params[:id])
    unless current_user == @post.user
        redirect_to root_path, alert: "Not authorized"
    end
   end

   def post_params
     params.require(:post).permit(:body, :snap, maps_attributes: [:id, :latitude, :longitude, :spot_name, :description, :photo_url, :_destroy])
   end

   def map_params
    params.require(:map).permit(:latitude, :longitude, :spot_name, :description, :photo_url)
   end
end
