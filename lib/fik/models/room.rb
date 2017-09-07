module Fik
  module Models
    class Room
      attr_reader :type, :description, :exits, :name, :item_ids, :actor_ids
      def initialize(hash, world)
        @world = world
        @description = hash["description"]
        @exits = hash["exits"]
        @name = hash["name"]
        @item_ids = hash["items"] || []
        @type = "room"
        @actor_ids = []
      end

      def print_name
        @name.gsub("_", " ")
      end
      
      def items
        @item_ids.map do |id|
          @world.items[id]
        end
      end
      
      def add_actor(actor_id)
        @actor_ids << actor_id
      end
      
      def remove_actor(actor_id)
        @actor_ids -= [actor_id]
      end
      
      def remove_item(item_id)
        @item_ids -= [item_id]
      end
      
      def add_item(item_id)
        @item_ids << item_id
      end
      
      def exit_directions
        @exits.keys
      end
    end
  end
end