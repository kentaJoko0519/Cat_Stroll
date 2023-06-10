class Admin::UsersController < ApplicationController
  # ユーザー一覧
  def index
    @users = User.all
  end
  
  # ユーザー詳細 
  def show
    @user=User.find(params[:id])
    @posts=@user.posts
  end
  
  # ユーザー情報編集
  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_user_path(@user.id)
  end
  
  private
  def user_params
    params.require(:user).permit(:first_name,:last_name,:first_name_kana,:last_name_kana, :email, :profile_image, :introduction, :user_name, :is_deleted)
  end
  
end
