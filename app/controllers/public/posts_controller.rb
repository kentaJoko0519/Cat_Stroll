class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :create, :edit, :update, :destroy]
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save!
    redirect_to post_path(@post.id)
  end

  def index
    @posts = Post.all
    # 検索機能
    if user_signed_in?
      if params[:search].present?
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
    else
      render :index
    end  
  end

  def show
    @post = Post.find(params[:id])
    @post.split_text
    @user = @post.user
    # コメント機能
    @comments = @post.comments  #投稿詳細に関連付けてあるコメントを全取得
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end  
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:user_id, :name, :address, :latitude, :longitude, :introduction, images: [])
  end

end
