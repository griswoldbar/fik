module Fik
  class Notifier
    def initialize(world)
      @world = world
    end
    
    def notify(notification)
      notification.recipients.each do |id|
        PrivatePub.publish_to "/#{id}", :message => notification.message
      end
    end
  end
end