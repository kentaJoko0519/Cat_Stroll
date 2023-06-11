class Admin::ReportsController < ApplicationController
  
  def index
    @reports = Report.all
  end

  def show
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    @report.update(report_params)
    if @report.reported.is_deleted == true
      @report.update(status: 2)
    end
    redirect_to admin_reports_path
  end
  
  private

  def report_params
    params.require(:report).permit(:status)
  end
  
end
