class PusherController < ApplicationController
  protect_from_forgery :except => :auth # stop rails CSRF protection for this action


  def auth
    if User.current
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id])
      render :json => response
    else
      render :text => "Not authorized", :status => '403'
    end
  end


  def test
    channel = ActsAsNotifiableRedmine::Notifications.find_by_id(params[:channel])
    event = channel.events.select{|x| x.name == params[:event].to_sym}.first

    sender = (params[:pusher] == 'true' ? 'Pusher' : 'Redmine')

    message = ""
    message << "This is a test message sent by #{sender}! <br/>"
    message << "This is event '#{event.name}' on channel '#{channel.name}' !!<br/>"
    message << "Stay on the air!"

    data = {}
    data[:title]   = 'Hello !!'
    data[:message] = message
    data[:image]   = "<img class=\"gritter-image\" src=\"/plugin_assets/redmine_pusher_notifications/images/ok.png\">"

    if params[:pusher] == 'true'
      begin
        ActsAsNotifiableRedmine::Notifications.send_notification(channel.token, event.name, data)
        @message = 'OK!'
        @error   = false
      rescue => e
        @message = e.message
        @error   = true
      end
    else
      gflash :now, :success => { :value => data[:message], :sticky => event.sticky?, :image => data[:image] }
      @message = 'OK!'
      @error   = false
    end
  end

end
