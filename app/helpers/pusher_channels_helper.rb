module PusherChannelsHelper

  def checked_image2(checked = true)
    if checked
      image_tag 'toggle_check.png'
    else
      image_tag 'exclamation.png'
    end
  end

end
