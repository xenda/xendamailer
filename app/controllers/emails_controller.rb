class EmailsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create

    if request.headers["Authorization"] != "ab5fb24039ba11df98790800200c9a66"
      return head(:unauthorized)
    end

    email = params[:email]    
    subject = email[:subject]
    sender = email[:sender]
    to = email[:to]
    raw = email[:raw]
        
    # Creating a new tracking in PivotalTracker
    story = Story.create(:name => subject, :requested_by => "Alvaro Pereyra" , :description => "#{subject} \n #{raw}" , :project_id => 70807)

    # We get the code
    code = story.id
    # We get the issue's url
    pivotal_issue_url = story.url
    
    # We inform our client that his requests is being taken care of
    IssueMailer.issue_received(sender,to,subject,code).deliver    
    
    #We inform the proper parties
    IssueMailer.issue_receive(sender, subject, code, pivotal_issue_url).deliver

    head :ok
    
  end
end