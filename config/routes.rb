match "pusher/auth", :to => "pusher#auth", :via => [:post]
match "pusher/test", :to => "pusher#test", :via => [:get], :as => 'pusher_event_test'
