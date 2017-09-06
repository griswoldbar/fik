module Fik
  module Models
    class Room
      attr_reader :description, :exits, :name
      def initialize(hash)
        @description = hash["description"]
        @exits = hash["exits"]
        @name = hash["name"]
        @objects = hash["objects"]
      end
    end
  end
end