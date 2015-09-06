module RedminePusherNotifications
  module Hooks
    class AddPusherClientJavascript < Redmine::Hook::ViewListener

      render_on :view_layouts_base_html_head, :partial => 'layouts/pusher'

    end
  end
end
