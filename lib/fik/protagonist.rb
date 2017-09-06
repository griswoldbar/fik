module Fik
  class Protagonist
    attr_reader :starting_room, :inventory
    
    def initialize(config)
      @name = config.keys.first
      attrs = config.first[1]
      @starting_room = attrs['starting_room']
      @inventory = attrs['inventory']
    end
  end
end