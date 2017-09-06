module Fik
  class GameBuilder
    def initialize(config)
      @config = config
    end
    
    def build
      Game.new(
        world:Fik::World.new(@config["rooms"]),
        protagonist: Fik::Protagonist.new(@config["protagonist"]),
        glossary: Fik::Glossary.new(@config)
      )
    end
    
  end
end