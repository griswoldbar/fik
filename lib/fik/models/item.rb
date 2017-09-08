module Fik
  module Models
    class Item
      attr_reader :type, :name, :takeable, :taken, :description, :starting_description, :callbacks
      
      alias_method :takeable?, :takeable
      alias_method :taken?, :taken

      def initialize(hash, world)
        @world = world
        @description = hash["description"]
        @starting_description = hash["starting_description"] || @description
        @name = hash["name"]
        @type = "item"
        @taken = false
        @takeable = hash["takeable"]
        @callbacks = hash["callbacks"]
      end
      
      def take
        @taken = true
      end
      
      def list_name
        "- #{name.with_indefinite_article}"
      end
    end
  end
end