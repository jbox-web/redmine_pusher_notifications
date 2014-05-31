module RedminePusherNotifications
  module Patches
    module UserPatch

      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
          unloadable
        end
      end

      module InstanceMethods

        def receive_pusher_notifications?
          self.custom_field_values.each do |custom|
            if custom.custom_field.name == 'Receive Pusher Notifications'
              return custom.value
            end
          end
          return false
        end

      end

    end
  end
end

unless User.included_modules.include?(RedminePusherNotifications::Patches::UserPatch)
  User.send(:include, RedminePusherNotifications::Patches::UserPatch)
end
