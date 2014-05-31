module RedminePusherNotifications
  module Hooks
    class AddPusherLibJavascript < Redmine::Hook::ViewListener

      def view_layouts_base_html_head(context={})
        if User.current.logged?
          header = ""
          header << javascript_include_tag(:pusher_min,          :plugin => 'redmine_pusher_notifications') + "\n"
          header << javascript_include_tag(:jquery_gritter_min,  :plugin => 'redmine_pusher_notifications') + "\n"
          header << stylesheet_link_tag(:jquery_gritter,         :plugin => 'redmine_pusher_notifications') + "\n"
          header
        end
      end

    end
  end
end
