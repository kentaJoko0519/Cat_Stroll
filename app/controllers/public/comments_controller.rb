class Public::CommentsController < ApplicationController
# 新規登録orログインしないとアクションが実行されない
  before_action :authenticate_user!
  

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end

  end
  
  def destroy
    comment = Comment.find(params[:post_id])
    comment.destroy
    redirect_to post_path(params[:post_id])
  end
  
  private
  def comment_params
    params.require(:comment).permit(:sentence, :post_id)  #formにてpost_idパラメータを送信して、コメントへpost_idを格納するようにする必要がある。
  end
  
end
