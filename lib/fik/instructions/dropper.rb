module Fik
  module Instructions
    class Dropper < ItemModifier      
      def execute
        if @protagonist.inventory.include?(@item_id)
          @protagonist.remove_item(@item_id)
          @current_room.add_item(@item_id)
          @notifications << OpenStruct.new(
            recipients: @current_room.actor_ids - [@protagonist.id],
            message: "#{@protagonist.name} dropped the #{@item_id}."
          )
          
          @messages << (@item_id + ": dropped.")
        else
          @messages << "You don't have a #{@item_id}."
        end
      end
    end
  end
end