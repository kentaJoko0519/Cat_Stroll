class Public::UsersController < ApplicationController

# ユーザー側  ユーザー

  # 新規登録orログインしないとアクションが実行されない
  before_action :authenticate_user!

# ユーザー一覧
  def index
    @users=User.where(is_deleted: false)                  # ユーザーの退会ステータスが false(有効)のユーザーを取得
    @following_users = current_user.following_user        # タブで切り替えれるように部分テンプレートの設定
    @follower_users = current_user.follower_user          # タブで切り替えれるように部分テンプレートの設定
  end

# ユーザー詳細
  def show
    @user=User.find(params[:id])                          # UserモデルのIDを取得して詳細ページを表示
    @posts=@user.posts                                    # @posts にはユーザーが過去投稿したものを取得
  end

# 退会確認
  def unsubscribe
    @user=current_user                                    # @user にログインしているユーザーを取得
  end

# 退会処理
  def withdraw
    @user=current_user                                      # @user にログインしているユーザーを取得
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

# マイページ
  def my_page
    @user=current_user           # @user→ログインしているユーザーの情報
    @posts=@user.posts           # @posts にはユーザーが過去投稿したものを取得
  end

# 登録情報編集
  def edit
    @user=current_user           # @user→ログインしているユーザーの情報
  end

  def update
    @user=current_user           # @user→ログインしているユーザーの情報
    if @user.update(user_params)    # 登録情報のアップデート
      flash[:notice] = "更新しました"
      redirect_to my_page_path     # マイページにリダイレクト
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name,:last_name,:first_name_kana,:last_name_kana, :email, :profile_image, :introduction, :user_name)
  end

end
