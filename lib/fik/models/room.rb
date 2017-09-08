module Fik
  module Models
    class Room
      attr_reader :type, :exits, :name, :item_ids, :actor_ids, :callbacks, :hidden_exits
      attr_accessor :description, :original_description
      
      def initialize(hash, world)
        @world = world
        @description = hash["description"]
        @exits = hash["exits"]
        @name = hash["name"]
        @item_ids = hash["items"] || []
        @type = "room"
        @actor_ids = []
        @hidden_exits = hash["hidden_exits"]
      end
      
      def open_hidden_exit(direction)
        he = @hidden_exits[direction]
        he["open"] = true
        @exits[direction] = he["id"]
      end
      
      def close_hidden_exit(direction)
        he = @hidden_exits[direction]
        he["open"] = false
        @exits.delete(direction)
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
  
    end
  end
end