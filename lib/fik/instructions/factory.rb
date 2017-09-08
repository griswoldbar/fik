require 'fik/instructions/item_modifier'
require 'fik/instructions/mover'
require 'fik/instructions/describer'
require 'fik/instructions/looker'
require 'fik/instructions/taker'
require 'fik/instructions/dropper'
require 'fik/instructions/inventory_lister'

module Fik
  module Instructions
    class Factory
      def initialize(instruction:, game:)
        @verb = instruction[0]
        @object = instruction[1]
        @game = game
      end
      
      def build
        instruction = case @verb
        when "go"
          Mover.new(direction: @object, game: @game)
        when "look"
          Looker.new(game: @game)
        when "inventory"
          InventoryLister.new(game: @game)
        when "describe"
          Describer.new(item_id: @object, game: @game)
        when "take"
          Taker.new(item_id: @object, game: @game)
        when "drop"
          Dropper.new(item_id: @object, game: @game)
        end
      end
    end
  end
end