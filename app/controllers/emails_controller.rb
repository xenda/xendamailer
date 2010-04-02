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
    
    campfire = Tinder::Campfire.new 'xenda', :token => '1769bcfa6c5fd00ff96749c1325a2d8491aad6f1'
    room = campfire.find_room_by_name 'General'

    messages = ["No quiero entromenterme, pero", 
                "¿Molesto? Espero que no ya que", 
                "¡Hola Avengers! Les comento que",
                "OH POR DIOS VAMOS A MORIR...",
                "¡Guarden a las mujeres y niños! ",
                "¿Todo bien por acá? ¿No tienen hambre? Creo que hay una cafetería en frente muy buena. Ah, por cierto, ",]
    exit_messages = [ "¡El primero en resolverla se gana un chocolate!",
                      "Y eso es todo. Que sigan teniendo un buen día. Jarvis off.",
                      "Bueno, tal vez no sea tan grave, pero mírenlo :)",
                      "Listo... creo que no queda más que decir. ¡A por ello!",
                      "¿La van a atender ahora? Me avisan cualquier cosa",
                      "And that's all folks!"]
                      
    random_header = messages.shuffle.first
    random_exit = exit_messages.shuffle.first
    
    room.speak "#{random_header} se ha registrado la incidencia #{code} de #{sender}"
    room.speak "Nos dicen ésto: #{subject}"
    room.speak random_exit

    head :ok
    
  end
end