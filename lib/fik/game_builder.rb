module Fik
  class GameBuilder
    def initialize(config)
      @config = config
    end
    
    def build
      Game.new(
        world: Fik::World.new(
          rooms: @config["rooms"], 
          items: @config["items"]),
        protagonist: Fik::Protagonist.new(@config["protagonist"])
      )
    end
    
  end
end