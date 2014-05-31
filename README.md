### A Redmine plugin which makes notifying your Redmine instance easy ;)

This plugin is designed to integrate the [Pusher Notification System](http://pusher.com) in Redmine to display nice notifications in Growl style.

## Code status

* [![Code Climate](https://codeclimate.com/github/jbox-web/redmine_pusher_notifications.png)](https://codeclimate.com/github/jbox-web/redmine_pusher_notifications)
* [![Dependency Status](https://gemnasium.com/jbox-web/redmine_pusher_notifications.svg)](https://gemnasium.com/jbox-web/redmine_pusher_notifications)

## Requirements

* Ruby 1.9.x or 2.0.x
* a working [Redmine](http://www.redmine.org/) installation
* an account on [Pusher](http://pusher.com)
* [gritter](https://github.com/RobinBrouwer/gritter) gem
* [acts_as_notifiable_redmine](https://github.com/jbox-web/acts_as_notifiable_redmine) gem

## Installation
  
    ## Before install the plugin, stop Redmine!
    
    root$ su - redmine
    redmine$ cd REDMINE_ROOT/plugins
    redmine$ git clone https://github.com/jbox-web/redmine_bootstrap_kit.git
    redmine$ git clone https://github.com/jbox-web/redmine_pusher_notifications.git
    redmine$ cd redmine_pusher_notifications/
    redmine$ git checkout v1.0.0
    redmine$ cd REDMINE_ROOT
    redmine$ bundle install

    ## After install the plugin, start Redmine!

## Configuration

Go to the plugin settings page within Redmine interface to configure your Pusher account informations. That's all!

## Copyrights & License
Redmine Pusher Notifications is completely free and open source and released under the [MIT License](https://github.com/jbox-web/redmine_pusher_notifications/blob/devel/LICENSE).

Copyright (c) 2013-2014 Nicolas Rodriguez (nrodriguez@jbox-web.com), JBox Web (http://www.jbox-web.com) [![endorse](https://api.coderwall.com/n-rodriguez/endorsecount.png)](https://coderwall.com/n-rodriguez)


## Contribute

You can contribute to this plugin in many ways such as :
* Helping with documentation
* Contributing code (features or bugfixes)
* Reporting a bug
* Submitting translations

You can also donate :)

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=FBT7E7DAVVEEU)
