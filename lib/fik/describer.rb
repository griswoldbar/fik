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
      items = room.items
      item_statement = items.map(&:starting_description).join("\n")
      
      actors = room.actor_ids - [@protagonist.id]
      actor_statement = actors.map {|a| "#{a} is here."}.join("\n")
      directions = room.exit_directions
      exit_prefix = directions.count == 1 ? "There is an exit" : "There are exits"
      exit_statement = "#{exit_prefix} to the #{directions.to_sentence}."
      
      [room.description, exit_statement, item_statement, actor_statement].compact.join("\n")
    end
  end
end