module Fik
  module Interfaces
    class Web  
      def initialize(game)
        @game = game
        @game.interface = self
      end
      
      def run(command)    
        @game.execute(command.split(" "))
      end
      
      def output(message)
        message
      end
    end
  end
end