# encoding: utf-8
require 'pusher'

require 'redmine'

require 'redmine_pusher_notifications'

Gritter.rails_flash_fallback = true

Redmine::Plugin.register :redmine_pusher_notifications do
  name 'Redmine Pusher Notifications'
  author 'Nicolas Rodriguez'
  description 'This is a plugin for Redmine to pub/sub notifications on Pusher Platform'
  version '1.0.0'
  url 'http://www.jbox-web.com'
  author_url 'mailto:nrodriguez@jbox-web.com'

  settings({
    :partial => 'settings/redmine_pusher_notifications',
    :default => {
      :pusher_app_id       => '',
      :pusher_key          => '',
      :pusher_secret       => '',
      :pusher_encrypted    => true,
      :popup_default_delay => 6000,
    }
  })

end

ActsAsNotifiableRedmine::Notifications.register_channel :channel_test do
  target Proc.new { User.current.login }
  event  :event1, :sticky => true
  event  :event2, :sticky => false
  event  :event3
end

ActsAsNotifiableRedmine::Notifications.register_channel :broadcast do
  target 'broadcast'
  event  :event1, :sticky => true
  event  :event2, :sticky => false
  event  :event3
end

Rails.configuration.after_initialize do
  ActsAsNotifiableRedmine::Notifications.register_courier :pusher do
    app_id    Setting.plugin_redmine_pusher_notifications[:pusher_app_id]
    key       Setting.plugin_redmine_pusher_notifications[:pusher_key]
    secret    Setting.plugin_redmine_pusher_notifications[:pusher_secret]
    encrypted Setting.plugin_redmine_pusher_notifications[:pusher_encrypted]
  end
end
