class Public::BookmarksController < ApplicationController
  
# ユーザー側  ブックマーク
  # 新規登録orログインしないとアクションが実行されない
  before_action :authenticate_user!
  # ブックマーク一覧
  def favorite
    @bookmarks = Bookmark.where(user_id: current_user.id)            # Bookmarkモデルの user_id カラムから current_user.id を全取得
  end
  
  # ブックマークに追加
  def create
    @post = Post.find(params[:post_id])                              # Postモデルの post_id を取得
    bookmark = @post.bookmarks.new(user_id: current_user.id)         # @post.bookmarks.new の user_id に current_user.id を紐づける
    if bookmark.save                                                 # もし、ブックマークに追加できたら
      flash[:notice] = "ブックマークに追加しました"
      redirect_to request.referer                                    # 同じ画面に戻る(ボタンの表示に変更あり)
    else
      redirect_to request.referer                                    # 同じ画面に戻る(ボタンの表示は変わらない)
    end
  end

  def destroy
    @post = Post.find(params[:post_id])                              # Postモデルの post_id を取得
    bookmark = @post.bookmarks.find_by(user_id: current_user.id)     # @post.bookmarks.new の user_id に current_user.id を紐づける
    if bookmark.present?                                             # ブックマークに追加してあるかの確認(２度押しのエラーを回避するため)
        bookmark.destroy                                             # ブックマークから削除
        flash[:alert] = "ブックマークを外しました"
        redirect_to request.referer                                  # 同じ画面に戻る(ボタンの表示に変更あり)
    else
        redirect_to request.referer                                  # 同じ画面に戻る(ボタンの表示は変わらない)
    end
  end
  
end
