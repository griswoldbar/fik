module Fik
  class Interpreter
    COMMANDS = [
      "describe",
      "look",
      "go",
      "inventory",
      "take",
      "drop",
      "push"
    ]
    
    SYNONYMS = {
      "examine" => "describe",
      "press" => "push"
    }
    
    TRANSLATIONS = {
      "n" => "go north",
      "s" => "go south",
      "e" => "go east",
      "w" => "go west",
      "d" => "go down",
      "u" => "go up",
      "north" => "go north",
      "south" => "go south",
      "east" => "go east",
      "west" => "go west",
      "down" => "go down",
      "up" => "go up",
      
      "l" => "look",
      "i" => "inventory"
    }
    
    def interpret(command)
      meth = command[0]
      if COMMANDS.include?(meth)
        command
      elsif synonym = SYNONYMS[meth]
        command[0] = synonym
        command
      elsif translation = TRANSLATIONS[meth]
        translation.split(" ")
      else
        nil
      end
    end
  end
end