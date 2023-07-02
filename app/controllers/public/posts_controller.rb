class Public::PostsController < ApplicationController
  
# ユーザー側  投稿

  # indexアクション以外は新規登録orログインしないとアクションが実行されない
  before_action :authenticate_user!, only: [:new, :show, :create, :edit, :update, :destroy]
  
  # 新規投稿
  def new
    @post = Post.new                          # 空のインスタンスを生成
  end

  def create
    @post = Post.new(post_params)             # データを新規登録するためのインスタンス生成
    @post.user_id = current_user.id           # 投稿の user_id には current_user.id を入れる
    if @post.save                               # データをデータベースに保存するためのsaveメソッド実行
      flash[:notice] = "投稿完了"
      redirect_to post_path(@post.id)           # 投稿した詳細へリダイレクト
    else 
      render :new
    end  
  end
  
  # 投稿一覧
  def index
    @posts = Post.all                         # 投稿の情報を全取得
    # 検索機能
    if user_signed_in?                        # もし、ユーザーがログインしているなら
      if params[:search].present?             # 検索のフォームに何か検索ワードが入っていたら
        # 投稿のタグから探す
        tag_posts = @posts.joins(:tags).distinct.where('tags.name like ?', "%#{params[:search]}%")
        # 投稿者を探す
        posts = @posts.joins(:user).where('posts.name like ?', "%#{params[:search]}%").or(
                # ↓ address を検索に入れることにより、地名で検索できるようにする
                @posts.joins(:user).where('posts.address like ?', "%#{params[:search]}%")).or(
                @posts.joins(:user).where('users.first_name like ?', "%#{params[:search]}%")).or(
                @posts.joins(:user).where('users.last_name like ?', "%#{params[:search]}%")).or(
                @posts.joins(:user).where('users.user_name like ?', "%#{params[:search]}%"))
        # tag_posts と posts で重複しないように uniq を設定
        @posts = (tag_posts + posts).uniq
      end
    else
      render :index                           # ユーザーがログインしていないなら、投稿一覧に render する
    end  
  end
  
  # 投稿詳細
  def show
    @post = Post.find(params[:id])            # PostモデルのIDを取得して詳細ページを表示
    @post.split_text                          # Postモデルの split_textメソッドを実行
    @user = @post.user                        # @user には投稿したユーザーを取得
    # コメント機能
    @comments = @post.comments                #投稿詳細に関連付けてあるコメントを全取得
    @comment = Comment.new                    # コメントの空のインスタンスを生成
  end

  # 投稿編集
  def edit
    @post = Post.find(params[:id])            # PostモデルのIDを取得して編集ページを表示
  end

  def update
    @post = Post.find(params[:id])            # PostモデルのIDを取得
    if @post.update(post_params)              # もし、編集された投稿がアップデートされたなら
      flash[:notice] = "更新しました"
      redirect_to post_path(@post.id)         # 詳細ページへリダイレクト
    else
      render :edit                            # アップデートされなければ、編集ページへ render される
    end  
  end

  # 投稿削除
  def destroy
    post = Post.find(params[:id])             # PostモデルのIDを取得
    post.destroy                              # 投稿の削除
    flash[:notice] = "投稿を削除しました"
    redirect_to posts_path                    # 投稿一覧ページへリダイレクト
  end

  private
  def post_params
    params.require(:post).permit(:user_id, :name, :address, :latitude, :longitude, :introduction, images: [])
  end

end
