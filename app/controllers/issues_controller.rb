class IssuesController < ApplicationController

  def index
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    IssueMailer.issue_sent(@user,params[:email][:content]).deliver
    redirect_to issues_path
  end
  
end