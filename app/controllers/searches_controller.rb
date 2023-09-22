class SearchesController < ApplicationController
  def search
    q = params[:q]

    @q_user = User.ransack(name_cont: q)
    @q_post = Post.ransack(body_cont: q)
    @q_map = Map.ransack(spot_name_cont: q)

    @results_user = @q_user.result(distinct: true).includes(:profile_image_attachment)
    @results_post = @q_post.result(distinct: true).includes(post_maps: :map)
    @results_map = @q_map.result(distinct: true)
  end
end
