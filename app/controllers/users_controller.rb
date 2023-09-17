class UsersController < ApplicationController

def show
  @user = User.find(params[:id])
end

def search
  @q = User.ransack(params[:q])
  @users = @q.result(distinct: true)
end

  def user_params
      params.require(:user).permit(:name, :profile, :snap)
  end
end
