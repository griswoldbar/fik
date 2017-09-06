module Fik
  class Describer    
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
      items = room.items
      item_statement = items.map(&:starting_description).join("\n")
      
      directions = room.exit_directions
      exit_prefix = directions.count == 1 ? "There is an exit" : "There are exits"
      exit_statement = "#{exit_prefix} to the #{directions.to_sentence}."
      
      [room.description, exit_statement, item_statement].compact.join("\n")
    end
  end
end