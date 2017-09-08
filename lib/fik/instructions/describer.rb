module Fik
  module Instructions
    class Describer < ItemModifier      
      def execute
        if @protagonist.inventory.include?(@item_id) || @current_room.item_ids.include?(@item_id)
          item = @world.find_by_name(@item_id)
          @messages << item.description
        else
          @messages << "You can't see any #{item_id} here"
        end
      end
    end
  end
end