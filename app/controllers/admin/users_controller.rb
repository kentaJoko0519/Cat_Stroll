class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
# 管理者側  ユーザー  
  
  # ユーザー一覧
  def index
    @users = User.all                         # ユーザーの情報を全取得
  end
  
  # ユーザー詳細 
  def show
    @user=User.find(params[:id])               # UserモデルのIDを取得して詳細ページを表示
    @posts=@user.posts                         # @postにユーザーが過去に投稿したものを取得
  end
  
  # ユーザー情報編集
  def edit
    @user=User.find(params[:id])               # UserモデルのIDを取得してユーザー情報編集ページを表示
  end

  def update
    @user=User.find(params[:id])               # UserモデルのIDを取得
    @user.update(user_params)                  # user_params の情報をアップデート(ユーザーの退会ステータスも編集可能)
    redirect_to admin_user_path(@user.id)      # ユーザー詳細ページへリダイレクト
  end
  
  private
  def user_params
    params.require(:user).permit(:first_name,:last_name,:first_name_kana,:last_name_kana, :email, :profile_image, :introduction, :user_name, :is_deleted)
  end
  
end
