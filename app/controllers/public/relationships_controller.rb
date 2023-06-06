class Public::RelationshipsController < ApplicationController
  
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
# フォロー中
  def following
    @user=User.find(params[:user_id])
    @following_users = @user.following_user
  end
# フォロワー
  def follower
    @user=User.find(params[:user_id])
    @follower_users = @user.follower_user
  end
end
