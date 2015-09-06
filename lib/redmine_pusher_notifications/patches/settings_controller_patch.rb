require_dependency 'settings_controller'

module RedminePusherNotifications
  module Patches
    module SettingsControllerPatch

      def self.included(base)
        base.class_eval do
          unloadable

          helper  :pusher_channels
        end
      end

    end
  end
end

unless SettingsController.included_modules.include?(RedminePusherNotifications::Patches::SettingsControllerPatch)
  SettingsController.send(:include, RedminePusherNotifications::Patches::SettingsControllerPatch)
end
