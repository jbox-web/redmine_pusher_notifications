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
    pusher_channel = ActsAsNotifiableRedmine::Notifications.find_by_id(params[:channel])
    channels = [pusher_channel.token]
    event = params[:event]
    data = {}

    message = ""
    message << "This is a test message ! <br/>"
    message << "This is event '#{event}' on channel '#{pusher_channel.name}' !!<br/>"
    message << "Stay on the air!"

    data[:title]   = 'Hello !!'
    data[:message] = message
    data[:image]   = "<img class=\"gritter-image\" src=\"/plugin_assets/redmine_pusher_notifications/images/ok.png\">"

    begin
      ActsAsNotifiableRedmine::Notifications.send_notification(channels, event, data)
      @message = 'OK!'
      @error   = false
    rescue => e
      @message = e.message
      @error   = true
    end
  end

end
