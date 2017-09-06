module Fik
  module Models
    class Room
      attr_reader :type, :description, :exits, :name
      def initialize(hash, world)
        @world = world
        @description = hash["description"]
        @exits = hash["exits"]
        @name = hash["name"]
        @item_ids = hash["items"] || []
        @type = "room"
      end

      def items
        @item_ids.map do |id|
          @world.items[id]
        end
      end
      
      def exit_directions
        @exits.keys
      end
    end
  end
end