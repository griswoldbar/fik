module Fik
  module Instructions
    class Describer < ItemModifier      
      def execute
        item = @world.find_by_name(@item_id)
        
        if @protagonist.inventory.include?(item.id) || (@current_room.item_ids.include?(item.id) && item.visible?)
          @messages << item.description
        else
          @messages << "You can't see any #{@item_id} here"
        end
      end
    end
  end
end