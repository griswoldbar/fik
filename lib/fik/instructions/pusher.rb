module Fik
  module Instructions
    class Pusher < ItemModifier      
      def execute
        item = @world.find_by_name(@item_id)

        if @current_room.item_ids.include?(@item_id) && item.visible?
          if item.pushable?
            push_response = item.push!
            @messages << (@item_id + ": pushed.")

            @messages << push_response
            
            @notifications = {
              recipient_ids: @current_room.actor_ids - [@protagonist.id],
              message: "#{@protagonist.name} pushed the #{@item_id}."
            }
          else
            @messages << "You can't push that!"
          end
        else
          @messages << "You can't see any #{@item_id} here!"
        end
      end
    end
  end
end