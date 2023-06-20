class Admin::PostsController < ApplicationController
  
# 管理者側  投稿
  
  # 投稿一覧
  def index
    @posts = Post.all                   # ユーザーの投稿を全取得
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
