module Fik
  class Notifier
    def initialize(world)
      @world = world
    end
    
    def notify(recipient_ids:, message:)
      recipients = recipient_ids.map {|id| @world.actors[id] }
      recipients.each {|r| r.add_message(message) }
    end
  end
end