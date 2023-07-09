class Public::BookmarksController < ApplicationController
  
# ユーザー側  ブックマーク
  before_action :authenticate_user!
  def favorite
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end
  
  def create
    @post = Post.find(params[:post_id])
    bookmark = @post.bookmarks.new(user_id: current_user.id)
    if bookmark.save
      flash[:notice] = "ブックマークに追加しました"
      redirect_to request.referer                                    # 同じ画面に戻る(ボタンの表示に変更あり)
    else
      redirect_to request.referer                                    # 同じ画面に戻る(ボタンの表示は変わらない)
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    bookmark = @post.bookmarks.find_by(user_id: current_user.id)
    if bookmark.present?                                             # ブックマークに追加してあるかの確認(２度押しのエラーを回避するため)
        bookmark.destroy
        flash[:alert] = "ブックマークを外しました"
        redirect_to request.referer
    else
        redirect_to request.referer
    end
  end
  
end
