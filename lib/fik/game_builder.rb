module Fik
  class GameBuilder
    def initialize(config, protagonist)
      @config = config
      @protagonist = protagonist
    end
    
    def build
      Game.new(
        Fik::World.new(
          rooms: @config["rooms"], 
          items: @config["items"]
        ),
        @protagonist
      )
    end
    
  end
end