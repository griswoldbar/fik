module Fik
  class CallbackRunner
    def initialize(world)
      @world = world
    end
    
    def execute(callback)
      verb = callback.keys.first
      object_id = callback[verb]
      object = @world.find_by_name(object_id)
      case verb
        when "realise"
          object.realise!
      end
    end
  end
end