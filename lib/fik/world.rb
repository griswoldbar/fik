module Fik
  class World
    attr_reader :rooms
    
    def initialize(room_hashes)
      @rooms = room_hashes.inject({}) {|memo, (k,v)| memo[k] = Models::Room.new(v) ; memo}
    end
    
  end
end