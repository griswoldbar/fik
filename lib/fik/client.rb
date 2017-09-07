require 'httparty'

module Fik
  class Client
    def initialize(url)
      @url = url
      @room = ""
    end
    
    def run
      puts "Enter name: "
      name = gets.chomp
      puts HTTParty.get("#{@url}/start?name=#{name}")
      system "clear"
      # poll_messages(name)
      command = "l"
      while true do
        response = HTTParty.get("#{@url}/run?name=#{name}&command=#{command}")
        set_room(response['room'])
        print_output(response['output'])
        printf "> "
        command = gets.chomp
        exit if command == "exit"

      end
    end
    
    private
    def set_room(name)
      unless @room == name
        @room = name
        print name + "\n\n"
      end
    end
    
    def print_output(text)
      print "\r"
      print text
    end
    
    def poll_messages(name)
      Thread.new do
        while true
          sleep 2
          response = HTTParty.get("#{@url}/messages?name=#{name}")
          if response.present?
            puts response
          end
        end
      end
    end
  end
end