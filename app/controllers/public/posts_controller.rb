class Public::PostsController < ApplicationController
  def new
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def create
  end
  
  private
  def post_params
    params.require(:post).permit(:user_id, :name, :address, :postal_code, :latitude, :longitude, :introduction)
  end
  
end
