module Fik
  module Callbacks
    class Opener
      def initialize(room:, direction:, game:, runner:)
        @notifier = game.notifier
        @game = game
        @room = room
        @direction = direction
        @hidden_exit = @room.hidden_exits[@direction]
        @runner = runner
      end
      
      def execute
        if @hidden_exit
          @room.open_hidden_exit(@direction)
          @room.original_description = @room.description
          @room.description = @room.description + "\n" + @hidden_exit["description"]
          if @hidden_exit["timeout"]
            delayed_close
          end
        end
      end
      
      private
      def delayed_close
        Thread.new do
          sleep @hidden_exit["timeout"]
          @room.description = @room.original_description
          @room.close_hidden_exit(@direction)
          
          if @hidden_exit["close_callback"]
            @runner.execute(@hidden_exit["close_callback"])
          end
          
          @notifier.notify(OpenStruct.new(
            recipients: @game.world.actor_ids,
            message: "<Bang!> Something just slammed shut somewhere..."
          ))
        end
      end
    end
  end
end