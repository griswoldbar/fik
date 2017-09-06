module Fik
  module Interfaces
    class CLI  
      def initialize(game)
        @game = game
        @game.interface = self
      end
      
      def run
        @game.execute(["look"])
        
        while true do
          printf ">"
          command = gets.chomp.split(" ")
          puts @game.execute(command)
        end
      end
      
      def output(message)
        puts message
      end
    end
  end
end