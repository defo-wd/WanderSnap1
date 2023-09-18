class ReportsController < ApplicationController
def new
  @report = Report.new
  @user = User.find(params[:reported_id])
  @post = params[:post_id].present? ? Post.find(params[:post_id]) : nil
end

def create
  @user = User.find(params[:report][:reported_id])
  @post = params[:report][:reported_post_id].present? ? Post.find(params[:report][:reported_post_id]) : nil
  @report = Report.new(report_params)
  if @report.save
    redirect_to root_path, notice: '通報が送信されました'
  else
    render :new
  end
end

private

def report_params
  params.require(:report).permit(:reason, :reporter_id, :reported_id, :reported_post_id)
end


end
