# Set up autoload of patches
Rails.configuration.to_prepare do
  # Patches
  require_dependency 'redmine_pusher_notifications/patches/gritter_patch'
  require_dependency 'redmine_pusher_notifications/patches/setting_patch'
  require_dependency 'redmine_pusher_notifications/patches/settings_controller_patch'
  require_dependency 'redmine_pusher_notifications/patches/user_patch'

  # Hooks
  require_dependency 'redmine_pusher_notifications/hooks/add_pusher_lib_javascript'
  require_dependency 'redmine_pusher_notifications/hooks/add_pusher_client_javascript'
end
