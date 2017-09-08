module Fik
  module Instructions
    class ItemModifier
      attr_reader :messages, :notifications, :callback
      
      def initialize(item_id:, game:)
        @item_id = item_id
        @protagonist = game.protagonist
        @world = game.world
        @current_room = game.current_room
        @messages = []
        @notifications = []
      end
      
      def execute
        raise NotImplementedError
      end
    end
  end
end