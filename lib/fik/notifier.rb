module Fik
  class Notifier
    def initialize(world)
      @world = world
    end
    
    def notify(recipient_ids:, message:)
      recipient_ids.each do |id|
        PrivatePub.publish_to "/#{id}", :message => message
      end
    end
  end
end