class FollowersController < ApplicationController

  def index
    @title = t "followers"
    @user = User.find_by id: params[:user_id]
    unless @user
      flash[:danger] = t "error"
      redirect_to root_url
    end
    @users = @user.followers.recent.paginate page: params[:page],
      per_page: Settings.per_page_users
    render "users/show_follow"
  end
end
