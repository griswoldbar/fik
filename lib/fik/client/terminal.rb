require 'curses'

module Fik
  class Terminal
    def initialize
      @header = Curses::Window.new(1, Curses.cols, 0, 0)
      @messages = Curses::Window.new(3, Curses.cols, 1,0)
      @body = Curses::Window.new(Curses.lines - 5, Curses.cols, 5,0)
    end
    
    def close
      Curses.close_screen
    end
    
    def header(text)
      @header.clear
      @header.addstr(text.upcase)
      @header.refresh
    end
    
    def body(text)
      @body.addstr(text)
      @body.refresh
    end
    
    def clear_body
      @body.clear
    end
    
    def get_body
      @body.getstr
    end
  end
end