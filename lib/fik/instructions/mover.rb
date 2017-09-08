module Fik
  module Instructions
    class Mover
      attr_reader :messages, :notifications, :callback
      
      def initialize(direction:, game:)
        @direction = direction
        @game = game
        @current_room = game.current_room
        @world = game.world
        @protagonist = game.protagonist
        @messages = []
        @callback = 'look'
        @notifications = []
      end
      
      def execute
        destination_ref = @current_room.exits[@direction]
        unless destination_ref 
          @messages << "You can't go that way."
          return
        end
        destination = @world.rooms[destination_ref]

        @current_room.remove_actor(@protagonist.id)
        destination.add_actor(@protagonist.id)
        @game.current_room = destination
      
        @messages << "You go #{@direction} to the #{destination.print_name}."

        @notifications << OpenStruct.new(
          recipients: destination.actor_ids - [@protagonist.id],
          message: "#{@protagonist.name} has entered."
        )
        @notifications << OpenStruct.new(
          recipients: @current_room.actor_ids,
          message: "#{@protagonist.name} has left the room."
        )
      end
    end
  end
end