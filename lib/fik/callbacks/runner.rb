require 'fik/callbacks/opener'

module Fik
  module Callbacks
    class Runner
      def initialize(world)
        @world = world
      end
      
      def execute(callback)
        instruction = callback.split(" ")
        verb = instruction[0]
        object_id = instruction[1]
        auxiliary = instruction[2]
        object = @world.find_by_name(object_id)
        case verb
          when "realise"
            object.realise!
          when "open"
            Callbacks::Opener.new(room: object, direction: auxiliary).execute
        end
      end
    end
  end
end