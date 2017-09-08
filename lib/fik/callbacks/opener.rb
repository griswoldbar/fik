module Fik
  module Callbacks
    class Opener
      def initialize(room:, direction:)
        @room = room
        @direction = direction
      end
      
      def execute
        hidden_exit = @room.hidden_exits[@direction]
        if hidden_exit
          @room.exits[@direction] = hidden_exit["id"]
          @room.description = @room.description + "\n" + hidden_exit["description"]
          @room.hidden_exits.delete(@direction)
        end
      end
    end
  end
end