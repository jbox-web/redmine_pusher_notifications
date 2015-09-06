module RedminePusherNotifications
  module Patches
    module GritterPatch

      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
          unloadable

          alias_method_chain :gflash, :redmine_pusher
        end
      end

      module InstanceMethods

        def asset_path(image)
          true
        end


        def gflash_with_redmine_pusher(*args)
          flashes = gflash_without_redmine_pusher(*args)
          return if flashes.nil?
          return flashes.html_safe
        end

      end

    end
  end
end

unless Gritter::Helpers.included_modules.include?(RedminePusherNotifications::Patches::GritterPatch)
  Gritter::Helpers.send(:include, RedminePusherNotifications::Patches::GritterPatch)
end
