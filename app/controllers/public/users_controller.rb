class Public::UsersController < ApplicationController
  before_action :authenticate_user!

# ユーザー一覧
  def index
    @users=User.where(is_deleted: false)
    @following_users = current_user.following_user
    @follower_users = current_user.follower_user
  end

# ユーザー詳細
  def show
    @user=User.find(params[:id])
    @posts=@user.posts
  end

# 退会確認
  def unsubscribe
    @user=current_user
  end

# 退会処理
  def withdraw
    @user=current_user
    reports = Report.where(reported_id: current_user.id)
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reports.each do |report|
      report.update(status: 2)
    end
    Bookmark.where(post_id: @user.posts.ids).destroy_all    # 退会した場合、他のユーザーのブックマークにある退会したユーザーの投稿も削除する
    @user.posts.destroy_all                                         #退会した場合、投稿したものも全て削除される
    Relationship.where(follower_id: current_user.id).destroy_all    #退会した場合、他のユーザーのフォロワーにある退会したユーザーもなくなる
    Relationship.where(followed_id: current_user.id).destroy_all    #退会した場合、フォローにある他のユーザーもなくなる
    @user.comments.destroy_all                                      #退会した場合、退会したユーザーがコメントしたものは全て削除する
    @user.bookmarks.destroy_all                                     #退会した場合、退会したユーザーのブックマークはなくなる
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

# マイページ
  def my_page
    # @user→ログインしているユーザーの情報
    @user=current_user
    @posts=@user.posts
  end

# 登録情報編集画面
  def edit
    # @user→ログインしているユーザーの情報
    @user=current_user
  end

# 登録情報編集
  def update
    @user=current_user
    @user.update(user_params)
    redirect_to my_page_path
  end

  private
  def user_params
    params.require(:user).permit(:first_name,:last_name,:first_name_kana,:last_name_kana, :email, :profile_image, :introduction, :user_name)
  end

end
