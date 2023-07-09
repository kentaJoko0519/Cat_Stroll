class Admin::PostsController < ApplicationController
# 管理者側  投稿
  before_action :authenticate_admin!
  
  def index
    @posts = Post.all
    # 検索機能
    if admin_signed_in?
      if params[:search].present?             # 検索のフォームに何か検索ワードが入っていたら
        # 投稿のタグから探す
        tag_posts = @posts.joins(:tags).distinct.where('tags.name like ?', "%#{params[:search]}%")
        # 投稿者、投稿ID、投稿場所を探す
        posts = @posts.joins(:user).where('posts.id like ?', "%#{params[:search]}%").or(
                @posts.joins(:user).where('posts.name like ?', "%#{params[:search]}%")).or(
                @posts.joins(:user).where('users.id like ?', "%#{params[:search]}%")).or(
                @posts.joins(:user).where('users.first_name like ?', "%#{params[:search]}%")).or(
                @posts.joins(:user).where('users.last_name like ?', "%#{params[:search]}%")).or(
                @posts.joins(:user).where('users.user_name like ?', "%#{params[:search]}%"))
        # tag_posts と posts で重複しないように uniq を設定
        @posts = (tag_posts + posts).uniq
      end
    end
    
    # 検索結果がなかった場合
    if params[:search].present? && @posts.count == 0
      flash[:alert] = "検索結果がありません"
      render :index
    end
    flash[:alert] = nil
  end
  
  def show
    @post = Post.find(params[:id])
    @user = @post.user
    # コメント機能
    @comments = @post.comments          #投稿詳細に関連付けてあるコメントを全て取得
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end
  
end
