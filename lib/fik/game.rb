module Fik
  class Game
    attr_writer :interface
    attr_reader :protagonist
    
    def initialize(world, protagonist)
      @world = world
      @protagonist = protagonist
      @current_room = @world.rooms[protagonist.starting_room]

      @describer = Describer.new(@protagonist)
      @interpreter = Interpreter.new
      @notifier = Notifier.new(@world)
      
      @current_room.add_actor(@protagonist.id)
      @world.add_actor(@protagonist)
    end
    
    def room_name
      @current_room.name
    end
    
    def execute(command)
      @messages = []
      instruction = @interpreter.interpret(command)
      if instruction
        send(*instruction)
        @interface.output(@messages.join("\n"))
      else
        @interface.output("I'm not sure what you meant...")
      end
    end
    
    private
    def look
      @messages << @describer.describe(@current_room)
    end
    
    def describe(item_id)
      if @protagonist.inventory.include?(item_id) || @current_room.item_ids.include?(item_id)
        item = @world.find_by_name(item_id)
        @messages << @describer.describe(item)
      else
        @messages << "You can't see any #{item_id} here"
      end
    end
    
    def go(direction)
      destination_ref = @current_room.exits[direction]
      unless destination_ref 
        @messages << "You can't go that way."
        return
      end
      destination = @world.rooms[destination_ref]

      @current_room.remove_actor(@protagonist.id)
      destination.add_actor(@protagonist.id)
      @current_room = destination
    
      @messages << "You go #{direction} to the #{destination.print_name}."

      @notifier.notify(
        recipient_ids: @current_room.actor_ids - [@protagonist.id],
        message: "#{@protagonist.name} has entered."
      )

      look
    end
    
    def inventory
      "You have:\n" + @protagonist.inventory.map {|i| "- #{i.with_indefinite_article}"}.join("\n")
    end
    
    def take(item_id)
      if @current_room.item_ids.include?(item_id)
        @world.find_by_name(item_id).take
        @protagonist.add_item(item_id)
        @current_room.remove_item(item_id)
        
        @notifier.notify(
          recipient_ids: @current_room.actor_ids - [@protagonist.id],
          message: "#{@protagonist.name} took the #{item_id}."
        )
        
        @messages << (item_id + ": taken.")
      else
        @messages << "You can't see any #{item_id} here!"
      end
    end
    
    def drop(item_id)
      if @protagonist.inventory.include?(item_id)
        @protagonist.remove_item(item_id)
        @current_room.add_item(item_id)
        @notifier.notify(
          recipient_ids: @current_room.actor_ids - [@protagonist.id],
          message: "#{@protagonist.name} dropped the #{item_id}."
        )
        
        @messages << (item_id + ": dropped.")
      else
        @messages << "You don't have a #{item_id}."
      end
    end
  end
end