module Fik
  class Game
    attr_writer :interface
    
    def initialize(world:, protagonist:, glossary:)
      @world = world
      @protagonist = protagonist
      @current_room = @world.rooms[protagonist.starting_room]
      @describer = Describer.new
      @glossary = glossary
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
    
    def describe(name=nil)
      object = @glossary.lookup(name || @current_room["name"])

      @interface.output(@describer.describe(object))
    end
    
    def go(direction)
      destination_ref = @current_room["exits"][direction]
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
  end
end