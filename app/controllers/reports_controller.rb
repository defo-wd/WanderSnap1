class ReportsController < ApplicationController
def new
  @report = Report.new
  @user = User.find(params[:user_id])
  @post = Post.find(params[:post_id])
end

def create
  @user = User.find(params[:report][:reported_id])
  @post = Post.find(params[:report][:reported_post_id])
  @report = Report.new(report_params)
  if @report.save
    redirect_to root_path, notice: '通報が送信されました'
  else
    render :new, alert: '通報の送信に失敗しました'
  end
end

private

def report_params
  params.require(:report).permit(:reason, :reporter_id, :reported_id, :reported_post_id)
end


end
