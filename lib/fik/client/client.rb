require 'httparty'

module Fik
  class Client
    def initialize(url)
      @url = url
      @room = ""
      @terminal = Terminal.new
    end
    
    def run
      @terminal.header("Welcome to Ghostly Castle")
      @terminal.body("Enter name: ")
      name = @terminal.get_body
      @terminal.clear_body
      @terminal.body(HTTParty.get("#{@url}/start?name=#{name}"))
      command = 'look'
      while true do
        response = HTTParty.get("#{@url}/run?name=#{name}&command=#{command}")
        set_room(response['room'])
        @terminal.body(response['output']+"\n> ")
        command = @terminal.get_body
        exit if command == "exit"
      end
    ensure
      @terminal.close
    end
    
    private
    def set_room(name)
      unless @room == name
        @room = name
        @terminal.header(name)
      end
    end
  end
end



# def run
# 
#   Curses.init_screen
#   
#   Curses.addstr "Enter name: "
#   name = Curses.getstr.chomp
#   Curses.addstr HTTParty.get("#{@url}/start?name=#{name}")
#   # system "clear"
#   # poll_messages(name)
#   command = "l"
#   while true do
#     response = HTTParty.get("#{@url}/run?name=#{name}&command=#{command}")
#     set_room(response['room'])
#     print_output(response['output'])
#     printf "> "
#     command = gets.chomp
#     exit if command == "exit"
# 
#   end
# ensure
#   Curses.close_screen
# end
# 

# 
# def print_output(text)
#   print "\r"
#   print text
# end
# 
# def poll_messages(name)
#   Thread.new do
#     while true
#       sleep 2
#       response = HTTParty.get("#{@url}/messages?name=#{name}")
#       if response.present?
#         puts response
#       end
#     end
#   end
# end