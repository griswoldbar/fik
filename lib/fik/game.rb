module Fik
  class Game
    attr_writer :interface
    
    def initialize(world:, protagonist:)
      @world = world
      @protagonist = protagonist
      @current_room = @world.rooms[protagonist.starting_room]
      @describer = Describer.new
      @interpreter = Interpreter.new
    end
    
    def execute(command)
      instruction = @interpreter.interpret(command)
      if instruction
        send(*instruction)
      else
        @interface.output("I'm not sure what you meant...")
      end
    end
    
    private
    def describe(name=nil)
      object = @world.find_by_name(name || @current_room.name)

      @interface.output(@describer.describe(object))
    end
    
    def go(direction)
      destination_ref = @current_room.exits[direction]
      unless destination_ref 
        @interface.output("You can't go that way.")
        return
      end
      
      destination = @world.rooms[destination_ref]
      @interface.output("You go #{direction} to the #{destination_ref}.")
      @current_room = destination
      describe
    end
    
    def inventory
      @interface.output("You have:\n" + @protagonist.inventory.map {|o| "- #{o.with_indefinite_article}"}.join("\n"))
    end
    
    def take(item_id)
      if @current_room.item_ids.include?(item_id)
        @protagonist.inventory << item_id
        @current_room.remove_item(item_id)
        @interface.output(item_id + ": taken.")
      else
        @interface.output("You can't see any #{item_id} here!")
      end
    end
  end
end