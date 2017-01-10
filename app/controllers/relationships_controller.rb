class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by params[:followed_id]
    current_user.follow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    redirect_incorrect_user @user
    current_user.unfollow @user
    create_user_unfollow_activity current_user, @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
end
