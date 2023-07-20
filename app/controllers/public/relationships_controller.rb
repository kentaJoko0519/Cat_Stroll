class Public::RelationshipsController < ApplicationController
# ユーザー側  フォロー
  before_action :authenticate_user!

  # フォローする
  def create
    current_user.follow(params[:user_id])       # current_user で 選択したユーザー(user_id)に対してfollowメソッドを実行
    redirect_to request.referer                 # 同じ画面に戻る
  end

  # フォローを外す
  def destroy
    current_user.unfollow(params[:user_id])     # current_user で 選択したユーザー(user_id)に対してunfollowメソッドを実行
    redirect_to request.referer
  end

# フォロー中
  def following
    @user = User.find(params[:user_id])
    @following_users = @user.following_user
  end

# フォロワー
  def follower
    @user = User.find(params[:user_id])
    @follower_users = @user.follower_user
  end
end
