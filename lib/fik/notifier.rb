module Fik
  class Notifier
    def initialize(world)
      @world = world
    end
    
    def notify(opts={})
      if opts[:recipient_ids]
        opts[:recipient_ids].each do |id|
          PrivatePub.publish_to "/#{id}", :message => opts[:message]
        end
      end
    end
  end
end