class EmailsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    if request.headers["Authorization"] != "ab5fb24039ba11df98790800200c9a66"
      return head(:unauthorized)
    end
    IssueMailer.receive(params[:email][:raw])
    head :ok
  end
end