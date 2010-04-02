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
    raw = raw.gsub("<strong>"," *").gsub("<b>"," *").gsub("</strong>","* ").gsub("</b>","* ").gsub("<em>"," _").gsub("<i>"," _").gsub("</em>","_ ").gsub("</i>","_ ").gsub(/<.*>/,"")
        
    # Creating a new tracking in PivotalTracker
    story = Story.create(:name => "#{subject}", :requested_by => "Alvaro Pereyra" , :description => "#{sender} \n #{raw}" , :project_id => 70807, :story_type=>"bug")

    # We get the code
    code = story.id
    
    story.name = "#{story.id} - #{subject}"
    story.save
    
    # We get the issue's url
    pivotal_issue_url = story.url
    
    # We inform our client that his requests is being taken care of
    IssueMailer.issue_received(sender,to,subject,code).deliver    
    
    #We inform the proper parties
    IssueMailer.issue_receive(sender, subject, code, pivotal_issue_url).deliver

    head :ok
    
  end
end