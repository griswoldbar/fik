module Fik
  module Models
    class Actor
      attr_reader :name, :id, :starting_room, :inventory
    
      def initialize(attrs)
        @name, @id = attrs["name"], attrs["name"]
        @starting_room = attrs["starting_room"]
        @inventory = []
        @inbox = []
      end

      def add_message(message)
        @inbox << message
      end
      
      def remove_item(item_id)
        @inventory -= [item_id]
      end
      
      def add_item(item_id)
        @inventory << item_id
      end
      
      def read_messages
        @inbox.tap { @inbox = [] }
      end
    end
  end
end