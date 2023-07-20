class Public::UsersController < ApplicationController
# ユーザー側  ユーザー
  before_action :authenticate_user!

  def index
    @users=User.where(is_deleted: false)                  # ユーザーの退会ステータスが false(有効)のユーザーを取得
    @following_users = current_user.following_user        # タブで切り替えれるように部分テンプレートの設定
    @follower_users = current_user.follower_user          # タブで切り替えれるように部分テンプレートの設定
    # 検索機能
    if params[:search].present?             # 検索のフォームに何か検索ワードが入っていたら
      users = @users.where('users.user_name like ?', "%#{params[:search]}%")
      following_users = @following_users.where('users.user_name like ?', "%#{params[:search]}%")
      follower_users = @follower_users.where('users.user_name like ?', "%#{params[:search]}%")
      #重複しないように uniq を設定
      @users = users.uniq
      @following_users = following_users.uniq
      @follower_users = follower_users.uniq
    end
    if params[:select].present?
      @select = params[:select]
    end
    # 検索結果がなかった場合
    if params[:search].present? && @users.count == 0
      flash[:alert] = "検索結果がありません"
      render :index
    end
    flash[:alert] = nil
  end

  def show
    @user=User.with_out_is_deleted.find(params[:id])
    @posts=@user.posts
  end

  def unsubscribe
    @user=current_user
  end

# 退会処理
  def withdraw #[ToDo]
    @user=current_user
    reports = Report.where(reported_id: current_user.id)    # 退会するユーザーが既に通報されているユーザの際に使用する
    @user.update(is_deleted: true)                          # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    reports.each do |report|                                # 通報されたユーザーの通報が複数ある場合
      report.update(status: 2)                              # 対応ステータスを"対応済み"に変更
    end
    Bookmark.where(post_id: @user.posts.ids).destroy_all            # 退会した場合、他のユーザーのブックマークにある退会したユーザーの投稿も削除する
    @user.posts.destroy_all                                         # 退会した場合、投稿したものも全て削除される
    Relationship.where(follower_id: current_user.id).destroy_all    # 退会した場合、他のユーザーのフォロワーにある退会したユーザーもなくなる
    Relationship.where(followed_id: current_user.id).destroy_all    # 退会した場合、フォローにある他のユーザーもなくなる
    @user.comments.destroy_all                                      # 退会した場合、退会したユーザーがコメントしたものは全て削除する
    @user.bookmarks.destroy_all                                     # 退会した場合、退会したユーザーのブックマークはなくなる
    reset_session                                           # すべてのセッション情報を削除
    redirect_to root_path                                   # 投稿一覧ページにリダイレクト
  end

  def my_page
    @user=current_user
    @posts=@user.posts
  end

  def edit
    @user=current_user
  end

  def update
    @user=current_user
    if @user.update(user_params)
      flash[:notice] = "更新しました"
      redirect_to my_page_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name,:last_name,:first_name_kana,:last_name_kana, :email, :profile_image, :introduction, :user_name)
  end

end
