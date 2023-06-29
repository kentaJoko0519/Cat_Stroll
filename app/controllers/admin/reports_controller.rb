class Admin::ReportsController < ApplicationController
  before_action :authenticate_admin!
# 管理者側  通報 
  
  # 通報一覧
  def index
    @reports = Report.all                      # ユーザーが通報した情報を全取得
  end
  
  # 通報詳細
  def show
    @report = Report.find(params[:id])         # ReportモデルのIDを取得して詳細ページを表示
  end

  # 通報詳細ページで対応ステータス変更
  def update
    @report = Report.find(params[:id])         # ReportモデルのIDを取得
    @report.update(report_params)              # 取得したIDの status(対応ステータス) を アップデート
    if @report.reported.is_deleted == true     # もし、通報されたユーザーの退会ステータスが is_deleted == true(退会) だった場合
      @report.update(status: 2)                # 取得したIDの status(対応ステータス) を "2" にアップデート
      # enum status ＝ waiting(対応待ち) → 0    keep(保留中) → 1    finish(対応済み) → 2
    end
    redirect_to admin_reports_path             # 通報一覧にリダイレクト
  end
  
  private

  def report_params
    params.require(:report).permit(:status)
  end
  
end
