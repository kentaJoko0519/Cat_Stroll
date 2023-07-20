class Admin::ReportsController < ApplicationController
# 管理者側  通報
  before_action :authenticate_admin!

  def index
    @reports = Report.all
  end

  def show
    @report = Report.find(params[:id])
  end

  # 通報詳細ページで対応ステータス変更
  def update
    @report = Report.find(params[:id])
    @report.update(report_params)
    if @report.reported.is_deleted == true     # もし、通報されたユーザーの退会ステータスが is_deleted == true(退会) だった場合
      @report.update(status: 2)                # 取得したIDの status(対応ステータス) を "2" にアップデート
      # enum status ＝ waiting(対応待ち) → 0    keep(保留中) → 1    finish(対応済み) → 2
    end
    flash[:notice] = "ステータス変更完了"
    redirect_to admin_reports_path
  end

  private

  def report_params
    params.require(:report).permit(:status)
  end

end
