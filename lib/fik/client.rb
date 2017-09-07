require 'httparty'

module Fik
  class Client
    def initialize(url)
      @url = url
    end
    
    def run
      puts "Enter name: "
      name = gets.chomp
      puts HTTParty.get("#{@url}/start?name=#{name}")
      
      poll_messages(name)
      while true do
        printf "> "
        command = gets.chomp
        exit if command == "exit"
        puts HTTParty.get("#{@url}/run?name=#{name}&command=#{command}")
      end
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