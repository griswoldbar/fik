require 'fik/callback_runner'
require 'fik/instructions/factory'
require 'ostruct'

module Fik
  class Game
    attr_writer :interface
    attr_reader :protagonist, :world
    attr_accessor :current_room
    
    def initialize(world, protagonist)
      @world = world
      @protagonist = protagonist
      @current_room = @world.rooms[protagonist.starting_room]

      @interpreter = Interpreter.new
      @notifier = Notifier.new(@world)
      @callback_runner = CallbackRunner.new(@world)
            
      @current_room.add_actor(@protagonist.id)
      @world.add_actor(@protagonist)
    end
    
    def room_name
      @current_room.name
    end
    
    def execute(command)
      instruction = @interpreter.interpret(command)
      
      unless instruction
        @interface.output("I'm not sure what you meant...")
        return
      end
      
      runner = Instructions::Factory.new(
        instruction: instruction,
        game: self
      ).build
      runner.execute
      
      @notifier.notify(runner.notifications) if runner.notifications
      self.execute(runner.callback) if runner.callback
      @interface.output(runner.messages.join("\n"))
    end
    
    private
    def run_callback(*instruction)
      object_ref = instruction[1]
      verb = instruction[0]
      if object_ref
        object = @world.find_by_name(object_ref)
        callback = object.callbacks[verb]
        @callback_runner.execute(callback) if callback
      else
        true
      end
    end
  
  end
end