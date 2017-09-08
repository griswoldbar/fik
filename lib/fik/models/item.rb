module Fik
  module Models
    class Item
      attr_reader :type, :name, :description, :starting_description,
        :takeable, :pushable, :taken, :pushed,
        :callbacks, :hidden
      
      alias_method :id, :name
      alias_method :takeable?, :takeable
      alias_method :pushable?, :pushable
      alias_method :taken?, :taken
      alias_method :hidden?, :hidden
      alias_method :pushed?, :pushed

      def initialize(hash, world)
        @world = world
        @description = hash["description"]
        @starting_description = hash["starting_description"] || @description
        @name = hash["name"]
        @type = "item"
        @taken = false
        @pushed = false
        @takeable = hash["takeable"]
        @pushable = hash["pushable"]
        @hidden = hash["hidden"]
        @callbacks = hash["callbacks"]
        @push_data = hash["push_data"]
      end
      
      def take!
        @taken = true
      end
      
      def unpush!
        @pushed = false
      end
      
      def push!
        if pushed?
          @push_data["fail"]
        else
          @pushed = true
          @push_data["success"]
        end
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