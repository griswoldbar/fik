module Fik
  class Describer   
    def initialize(protagonist)
      @protagonist = protagonist
    end
    
    def describe(thing)
      #TODO: only allow things that can be seen to be described
      if thing.type == "room"
        describe_room(thing)
      else
        thing.description
      end
    end
    
    private
    def describe_room(room)
      starting_item_statement = room.items.reject(&:taken?).map(&:description).join("\n")
      
      left_items = room.items.select(&:taken?)
      left_item_statement = if left_items.any?
        %Q{Also here are: \n#{left_items.map(&:list_name).join("\n")}}
      end
      
      actors = room.actor_ids - [@protagonist.id]
      actor_statement = if actors.any? 
        actors.map {|a| "#{a} is here."}.join("\n")
      end
      
      # directions = room.exit_directions
      # exit_prefix = directions.count == 1 ? "There is an exit" : "There are exits"
      # exit_statement = "#{exit_prefix} to the #{directions.to_sentence}."
      
      [room.description + "\n", starting_item_statement, actor_statement, left_item_statement].compact.join("\n")
    end
  end
end