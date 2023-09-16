class MapsController < ApplicationController
  before_action :set_map, only: [:show, :edit, :update, :destroy]

  def new
    @map = Map.new
  end

  def create
    @map = Map.new(map_params)

    if @map.save
      redirect_to @map, notice: 'Map was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @map.update(map_params)
      redirect_to @map, notice: 'Map was successfully updated.'
    else
      render :edit
    end
  end

  def index
    @maps = Map.all
    @post = Post.new
    @posts = Post.all
  end

def search
  @q = Map.ransack(params[:q])
  @maps = @q.result(distinct: true)
end



  private

  def set_map
    @map = Map.find(params[:id])
  end

  def map_params
    params.require(:map).permit(:latitude, :longitude, :spot_name, :description, :photo_url)
  end
end
