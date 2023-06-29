class Public::RelationshipsController < ApplicationController
  # 新規登録orログインしないとアクションが実行されない
  before_action :authenticate_user!
  
# ユーザー側  フォロー  
  
  # フォローする
  def create
    current_user.follow(params[:user_id])       # current_user で 選択したユーザー(user_id)に対してfollowメソッドを実行
    redirect_to request.referer                 # 同じ画面に戻る
  end
  
  # フォローを外す
  def destroy
    current_user.unfollow(params[:user_id])     # current_user で 選択したユーザー(user_id)に対してunfollowメソッドを実行
    redirect_to request.referer                 # 同じ画面に戻る
  end
  
# フォロー中
  def following
    @user = User.find(params[:user_id])         # Userモデルの user_id を取得
    @following_users = @user.following_user     # @following_users にはフォローしている user_id を取得
  end
  
# フォロワー
  def follower
    @user = User.find(params[:user_id])         # Userモデルの user_id を取得
    @follower_users = @user.follower_user       # @follower_users にはフォローしている user_id を取得
  end
end
