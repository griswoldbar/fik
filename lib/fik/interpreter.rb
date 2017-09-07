module Fik
  class Interpreter
    COMMANDS = [
      "describe",
      "look",
      "go",
      "inventory",
      "take",
      "drop"
    ]
    
    TRANSLATIONS = {
      "n" => "go north",
      "s" => "go south",
      "e" => "go east",
      "w" => "go west",
      "d" => "go down",
      "u" => "go up",

      "l" => "look",
      "i" => "inventory"
    }
    
    def interpret(command)
      meth = command[0]
      if COMMANDS.include?(meth)
        command
      elsif translation = TRANSLATIONS[meth]
        translation.split(" ")
      else
        nil
      end
    end
  end
end