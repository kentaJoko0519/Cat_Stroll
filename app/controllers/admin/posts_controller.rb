class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
# 管理者側  投稿
  
  # 投稿一覧
  def index
    @posts = Post.all                   # ユーザーの投稿を全取得
    # 検索機能
    if admin_signed_in?                        # もし、ユーザーがログインしているなら
      if params[:search].present?             # 検索のフォームに何か検索ワードが入っていたら
        # 投稿のタグから探す
        tag_posts = @posts.joins(:tags).distinct.where('tags.name like ?', "%#{params[:search]}%")
        # 投稿者を探す
        posts = @posts.joins(:user).where('posts.name like ?', "%#{params[:search]}%").or(
                @posts.joins(:user).where('users.first_name like ?', "%#{params[:search]}%")).or(
                @posts.joins(:user).where('users.last_name like ?', "%#{params[:search]}%")).or(
                @posts.joins(:user).where('users.user_name like ?', "%#{params[:search]}%"))
        # tag_posts と posts で重複しないように uniq を設定
        @posts = (tag_posts + posts).uniq
      end
    end
  end
  
  # 投稿詳細
  def show
    @post = Post.find(params[:id])      # PostモデルのIDを取得して詳細ページを表示
    @user = @post.user                  # @userには投稿したユーザーを表示
    # コメント機能
    @comments = @post.comments          #投稿詳細に関連付けてあるコメントを全て取得
  end

  # 投稿削除
  def destroy
    post = Post.find(params[:id])       # 削除する投稿のIDを取得
    post.destroy                        # 投稿を削除
    redirect_to admin_posts_path        # 投稿一覧ページにリダイレクト
  end
  
end
