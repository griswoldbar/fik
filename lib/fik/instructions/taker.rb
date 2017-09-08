module Fik
  module Instructions
    class Taker < ItemModifier      
      def execute
        item = @world.find_by_name(@item_id)

        if @current_room.item_ids.include?(@item_id) && item.visible? 
          if item.takeable?
            item.take!
            @protagonist.add_item(@item_id)
            @current_room.remove_item(@item_id)
            
            @notifications = {
              recipient_ids: @current_room.actor_ids - [@protagonist.id],
              message: "#{@protagonist.name} took the #{@item_id}."
            }
            
            @messages << (@item_id + ": taken.")
          else
            @messages << "You can't pick that up!"
          end
        else
          @messages << "You can't see any #{@item_id} here!"
        end
      end
    end
  end
end