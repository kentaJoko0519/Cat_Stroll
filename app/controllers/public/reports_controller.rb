class Public::ReportsController < ApplicationController
  
  def new
    @report = Report.new                   #新しい通報の箱を用意
    @user = User.find(params[:user_id])    #どのユーザーに対する通報なのかparamsで取得する
  end

  def create
    @user = User.find(params[:user_id])    #どのユーザーに対する通報なのかparamsで取得する
    @report = Report.new(report_params)    #ストロングパラメータを通す
    @report.user_id = current_user.id
    @report.reporter_id = current_user.id  #通報者(reporter_id)にcurrent_user.idを代入
    @report.reported_id = @user.id          #通報される人(reported_id)に上で取得した@user.idを代入
    if @report.save                         #保存する
      redirect_to user_path(@user)
    else
      render "new"
    end  
  end
  
  private

  def report_params
    params.require(:report).permit(:reason)
  end
  
end
