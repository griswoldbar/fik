module Fik
  class Interpreter
    COMMANDS = [
      "describe",
      "go",
      "inventory",
      "take"
    ]
    
    TRANSLATIONS = {
      "n" => "go north",
      "s" => "go south",
      "e" => "go east",
      "w" => "go west",
      "l" => "describe",
      "look" => "describe",
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