require 'curses'

module Fik
  module Client
    class Terminal
      def initialize
        Curses.start_color
        @header = Curses::Window.new(1, Curses.cols, 0, 0)
        @messages = Curses::Window.new(3, Curses.cols, 1,0)
        @body = Curses::Window.new(Curses.lines - 6, Curses.cols, 5,0)
        
        Curses.init_pair(1, Curses::COLOR_BLACK, Curses::COLOR_WHITE)
        @header.attrset(Curses.color_pair(1))
        @messages.scrollok(true)
      end
      
      def close
        Curses.close_screen
      end
      
      def header(text)
        @header.clear
        @header.addstr(text.upcase.gsub("_", " "))
        @header.refresh
      end
      
      def body(text)
        @body.clear
        @body.addstr(wrap(text))
        @body.addstr("> ")
        @body.refresh
      end
      
      def messages(text)
        @messages.addstr("\n" + text)
        @messages.refresh
      end
      
      def clear_body
        @body.clear
      end
      
      def get_body
        @body.getstr
      end
      
      private
      def wrap(s, width=Curses.cols)
        s ||= ""
	      s.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
	    end
    end
  end
end