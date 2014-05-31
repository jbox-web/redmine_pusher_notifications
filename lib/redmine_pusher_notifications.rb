# Set up autoload of patches
def apply_patch(&block)
  ActionDispatch::Callbacks.to_prepare(&block)
end

apply_patch do
  # Redmine
  require_dependency 'setting'
  require_dependency 'user'

  # Patches
  require_dependency 'redmine_pusher_notifications/patches/gritter_patch'
  require_dependency 'redmine_pusher_notifications/patches/setting_patch'
  require_dependency 'redmine_pusher_notifications/patches/user_patch'

  # Hooks
  require_dependency 'redmine_pusher_notifications/hooks/add_pusher_lib_javascript'
  require_dependency 'redmine_pusher_notifications/hooks/add_pusher_client_javascript'
end
