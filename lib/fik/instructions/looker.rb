module Fik
  module Instructions
    class Looker
      attr_reader :messages, :notifications, :callback
      
      def initialize(game:)
        @room = game.current_room
        @protagonist = game.protagonist
        @messages = []
        @notifications = []
      end
      
      def execute
        starting_item_statement = @room.items.select(&:visible?).reject(&:taken?).map(&:starting_description).join("\n")
        
        left_items = @room.items.select(&:taken?)
        left_item_statement = if left_items.any?
          %Q{Also here are: \n#{left_items.map(&:list_name).join("\n")}}
        end
        
        actors = @room.actor_ids - [@protagonist.id]
        actor_statement = if actors.any? 
          actors.map {|a| "#{a} is here."}.join("\n")
        end
              
        @messages << [@room.description + "\n", starting_item_statement, actor_statement, left_item_statement].compact.join("\n")
      end
    end
  end
end