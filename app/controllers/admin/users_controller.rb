class Admin::UsersController < ApplicationController
# 管理者側  ユーザー  
  before_action :authenticate_admin!
  
  def index
    @users = User.all
  end
  
  def show
    @user=User.find(params[:id])
    @posts=@user.posts
  end
  
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
