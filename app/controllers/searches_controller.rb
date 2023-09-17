class SearchesController < ApplicationController
  def search
    q = params[:q]

    @q_user = User.ransack(name_cont: q)
    @q_post = Post.ransack(body_cont: q)
    @q_map = Map.ransack(spot_name_cont: q)

    @results_user = @q_user.result(distinct: true)
    @results_post = @q_post.result(distinct: true)
    @results_map = @q_map.result(distinct: true)
  end
end
