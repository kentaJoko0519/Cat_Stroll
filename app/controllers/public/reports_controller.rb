class Public::ReportsController < ApplicationController
  # 新規登録orログインしないとアクションが実行されない
  before_action :authenticate_user!
  
# ユーザー側  通報
  
  # 通報
  def new
    @report = Report.new                       # 空のインスタンスを生成
    @user = User.find(params[:user_id])        # どのユーザーに対する通報なのかparamsで取得する
  end

  def create
    @user = User.find(params[:user_id])        # どのユーザーに対する通報なのかparamsで取得する
    @report = Report.new(report_params)        # ストロングパラメータを通す
    @report.user_id = current_user.id          # user_id にcurrent_user.idを入れる
    @report.reporter_id = current_user.id      # 通報者(reporter_id)にcurrent_user.idを入れる
    @report.reported_id = @user.id             # 通報される人(reported_id)に上で取得した@user.idを入れる
    if @report.save                            # もし、保存されたなら
      redirect_to user_path(@user)             # ユーザー詳細ページにリダイレクト
    else
      render "new"                             # 保存されなければ、通報ページに render
    end  
  end
  
  private

  def report_params
    params.require(:report).permit(:reason)
  end
  
end
