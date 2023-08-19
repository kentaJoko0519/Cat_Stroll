class Admin::UsersController < ApplicationController
# 管理者側  ユーザー
  before_action :authenticate_admin!

  def index
    @users = User.all.page(params[:page]).per(10)
    # 検索機能
    if admin_signed_in?
      if params[:search].present?             # 検索のフォームに何か検索ワードが入っていたら
        # ユーザーネーム、ID、ステータスで探す
        users = @users.where('users.is_deleted like ?', "%#{params[:search]}%").or(
                @users.where('users.first_name like ?', "%#{params[:search]}%")).or(
                @users.where('users.last_name like ?', "%#{params[:search]}%")).or(
                @users.where('users.user_name like ?', "%#{params[:search]}%"))
        # 重複しないように uniq を設定
        @users = users.uniq
      end
    end
    if params[:search].present? && @users.count == 0
      flash[:alert] = "検索結果がありません"
      render :index
    end
    flash[:alert] = nil
  end

  def show
    @user=User.find(params[:id])
    @posts=@user.posts.page(params[:page])
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    @user.update(user_params)
    flash[:notice] = "登録情報変更完了"
    redirect_to admin_user_path(@user.id)
  end

  private
  def user_params
    params.require(:user).permit(:first_name,:last_name,:first_name_kana,:last_name_kana, :email, :profile_image, :introduction, :user_name, :is_deleted)
  end

end
