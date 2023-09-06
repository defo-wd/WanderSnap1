class UsersController < ApplicationController



  def user_params
      params.require(:user).permit(:name, :profile, :snap)
  end
end
