class Public::ReportsController < ApplicationController
# ユーザー側  通報  
  before_action :authenticate_user!
  
  def new
    @report = Report.new
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
    @report = Report.new(report_params)
    @report.user_id = current_user.id          # user_id にcurrent_user.idを入れる
    @report.reporter_id = current_user.id      # 通報者(reporter_id)にcurrent_user.idを入れる
    @report.reported_id = @user.id             # 通報される人(reported_id)に上で取得した@user.idを入れる
    if @report.save
      flash[:notice] = "このユーザーを通報しました"
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "通報に失敗しました"
      render :new
    end  
  end
  
  private

  def report_params
    params.require(:report).permit(:reason)
  end
  
end
