module Fik
  class World
    attr_reader :rooms, :items, :actors
    
    def initialize(rooms:, items:)
      @rooms = rooms.inject({}) {|memo, (k,v)| memo[k] = Models::Room.new(v, self) ; memo}
      @items = (items || []).inject({}) {|memo, (k,v)| memo[k] = Models::Item.new(v, self) ; memo}
      @actors = {}
    end
    
    def add_actor(actor)
      @actors[actor.id] = actor
    end
    
    def find_by_name(name)
      @rooms[name] || @items[name]
    end
  end
end