module Fik
  module Instructions
    class InventoryLister
      attr_reader :messages, :notifications, :callback
      
      def initialize(game:)
        @protagonist = game.protagonist
        @messages = []
      end
      
      def execute
        @messages << "You have:\n" + @protagonist.inventory.map {|i| "- #{i.with_indefinite_article}"}.join("\n")
      end
    end
  end
end