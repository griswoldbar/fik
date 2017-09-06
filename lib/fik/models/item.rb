module Fik
  module Models
    class Item
      attr_reader :type, :description, :starting_description, :name
      def initialize(hash, world)
        @world = world
        @description = hash["description"]
        @starting_description = hash["starting_description"]
        @name = hash["name"]
        @type = "item"
      end
    end
  end
end