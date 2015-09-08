## ![logo](https://raw.github.com/jbox-web/redmine_pusher_notifications/gh-pages/images/pusher_logo.png) A Redmine plugin which makes notifying your Redmine instance easy ;)

[![GitHub license](https://img.shields.io/github/license/jbox-web/redmine_pusher_notifications.svg)](https://github.com/jbox-web/redmine_pusher_notifications/blob/devel/LICENSE)
[![GitHub release](https://img.shields.io/github/release/jbox-web/redmine_pusher_notifications.svg)](https://github.com/jbox-web/redmine_pusher_notifications/releases/latest)
[![Code Climate](https://codeclimate.com/github/jbox-web/redmine_pusher_notifications.png)](https://codeclimate.com/github/jbox-web/redmine_pusher_notifications)
[![Dependency Status](https://gemnasium.com/jbox-web/redmine_pusher_notifications.svg)](https://gemnasium.com/jbox-web/redmine_pusher_notifications)
[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=FBT7E7DAVVEEU)

This plugin is designed to integrate the [Pusher Notification System](http://pusher.com) in Redmine to display nice notifications in Growl style.

It aims to serve as a central point to store Pusher configuration.

It relies on the  [acts_as_notifiable_redmine](https://github.com/jbox-web/acts_as_notifiable_redmine) gem so plugins developpers can access to the DSL provided to register their own channels and events (see the doc below).

The [acts_as_notifiable_redmine](https://github.com/jbox-web/acts_as_notifiable_redmine) also provides a method to send **asynchronous** notifications via Pusher.

It also relies on [gritter](https://github.com/RobinBrouwer/gritter) gem to display notifications so plugins developpers also have access to its functionalities in their controllers like [```gflash```](https://github.com/RobinBrouwer/gritter#gflash) **synchronous** notifications ;).

You can take a look to the [```pusher```](https://github.com/jbox-web/redmine_pusher_notifications/blob/devel/app/controllers/pusher_controller.rb) controller which implements the both methods.

![screenshot](https://raw.github.com/jbox-web/redmine_pusher_notifications/gh-pages/images/screenshot.png)

## Requirements

* Ruby 1.9.x or 2.0.x
* a working [Redmine](http://www.redmine.org/) installation
* a free account on [Pusher](http://pusher.com)
* [acts_as_notifiable_redmine](https://github.com/jbox-web/acts_as_notifiable_redmine) gem
* [gritter](https://github.com/RobinBrouwer/gritter) gem

## Installation

    ## Before install the plugin, stop Redmine!

    root$ su - redmine
    redmine$ cd REDMINE_ROOT/plugins
    redmine$ git clone https://github.com/jbox-web/redmine_bootstrap_kit.git
    redmine$ git clone https://github.com/jbox-web/redmine_pusher_notifications.git
    redmine$ cd redmine_pusher_notifications/
    redmine$ git checkout v1.0.2
    redmine$ cd REDMINE_ROOT
    redmine$ bundle install

    ## After install the plugin, start Redmine!

## Configuration

Go to the plugin settings page within Redmine interface to configure your Pusher account informations. That's all!

## Plugin developpers

If you want to integrate Pusher async notifications in your plugin, or just Gitter with ```gflash``` you may need to register your own channels and events in your ```init.rb``` file : each channel can have many events. It may also have an optional ```target``` parameter which can be a string or a Proc.

    ## it must be OUTSIDE of the Redmine::Plugin.register block

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

Then to send notifications you have 2 options :
* **asynchronous** notifications via Pusher
* **synchronous** notifications sent by the controller

For **asynchronous** notifications :

    ActsAsNotifiableRedmine::Notifications.send_notification([channel.token], event.name, {:title => 'Hello!', :message => 'This is a test message !'})

**Note :** The logic to determine wether or not to send a notification is let to the developer. You can easily do this with callbacks :

    class Comment < ActiveRecord::Base
        has_many :watchers
        after_create :send_notification

        private

            def send_notification
                channels = []
                watchers.each do |watcher|
                    token = '<channel_name>-' + watcher.login
                    channels.push(token)
                end
                ActsAsNotifiableRedmine::Notifications.send_notification(channels, <event_name>, {:title => 'Hello!', :message => 'This is a test message !'})
            end
    end

For **synchronous** notifications :

In a controller :

    def test
      data = {}
      data[:message] = 'Hello!'
      data[:sticky] = true
      data[:image] = "<img class=\"gritter-image\" src=\"/plugin_assets/redmine_pusher_notifications/images/ok.png\">"
      gflash :now, :success => { :value => data[:message], :sticky => data[:sticky], :image => data[:image] }
    end

In a JS partial :

    $(document).ready(function() {
      <%= gflash :js => true %>
    });

In a HTML partial :

    <%= link_to 'Test me!', test_path, :remote => true %>

For more details, take a look at [gritter](https://github.com/RobinBrouwer/gritter#gflash).

## Contribute

You can contribute to this plugin in many ways such as :
* Helping with documentation
* Contributing code (features or bugfixes)
* Reporting a bug
* Submitting translations

You can also donate :)
