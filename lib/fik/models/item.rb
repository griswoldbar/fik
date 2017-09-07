module Fik
  module Models
    class Item
      attr_reader :type, :name
      
      def initialize(hash, world)
        @world = world
        @description = hash["description"]
        @starting_description = hash["starting_description"]
        @name = hash["name"]
        @type = "item"
        @taken = false
      end
      
      def take
        @taken = true
      end
      
      def taken?
        @taken
      end
      
      def description
        taken? ? @description : @starting_description
      end
      
      def list_name
        "- #{name.with_indefinite_article}"
      end
    end
  end
end