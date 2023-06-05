class Public::RelationshipsController < ApplicationController
  
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def following
    @following_users = current_user.following_user
  end

  def follower
    @follower_users = current_user.follower_user
  end
end
