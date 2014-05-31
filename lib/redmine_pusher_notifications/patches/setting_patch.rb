module RedminePusherNotifications
  module Patches
    module SettingPatch

      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
          unloadable

          before_save :save_pusher_values
          after_save  :set_pusher_config
        end
      end

      module InstanceMethods

        private

        def save_pusher_values
          # Only validate settings for our plugin
          if self.name == 'plugin_redmine_pusher_notifications'

            valuehash = self.value

            if valuehash[:pusher_encrypted] == 'true'
              valuehash[:pusher_encrypted] = true
            else
              valuehash[:pusher_encrypted] = false
            end

            # Save back results
            self.value = valuehash
          end
        end


        def set_pusher_config
          # Only validate settings for our plugin
          if self.name == 'plugin_redmine_pusher_notifications'
            valuehash = self.value

            ActsAsNotifiableRedmine::Notifications.register_courier :pusher do
              app_id    valuehash[:pusher_app_id]
              key       valuehash[:pusher_key]
              secret    valuehash[:pusher_secret]
              encrypted valuehash[:pusher_encrypted]
            end

          end
        end

      end

    end
  end
end

unless Setting.included_modules.include?(RedminePusherNotifications::Patches::SettingPatch)
  Setting.send(:include, RedminePusherNotifications::Patches::SettingPatch)
end
