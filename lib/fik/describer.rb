module Fik
  class Describer    
    def describe(thing)
      #TODO: only allow things that can be seen to be described
      type = thing["type"]
      if type == "room"
        describe_room(thing)
      else
        thing["description"]
      end
    end
    
    private
    def describe_room(room)
      directions = room["exits"].keys
      exit_prefix = directions.count == 1 ? "There is an exit" : "There are exits"
      room["description"] + " #{exit_prefix} to the #{directions.to_sentence}."
    end
  end
end