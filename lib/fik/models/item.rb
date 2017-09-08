module Fik
  module Models
    class Item
      attr_reader :type, :name, :takeable, :taken, :description, :starting_description, :callbacks, :hidden
      
      alias_method :id, :name
      alias_method :takeable?, :takeable
      alias_method :taken?, :taken
      alias_method :hidden?, :hidden

      def initialize(hash, world)
        @world = world
        @description = hash["description"]
        @starting_description = hash["starting_description"] || @description
        @name = hash["name"]
        @type = "item"
        @taken = false
        @takeable = hash["takeable"]
        @hidden = hash["hidden"]
        @callbacks = hash["callbacks"]
      end
      
      def take!
        @taken = true
      end
      
      def realise!
        @hidden = false
      end
      
      def visible?
        !@hidden
      end
      
      def list_name
        "- #{name.with_indefinite_article}"
      end
    end
  end
end