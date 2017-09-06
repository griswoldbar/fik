require 'httparty'

module Fik
  class Client
    def initialize(url)
      @url = url
    end
    
    def run
      while true do
        printf "> "
        command = gets.chomp
        
        response = if command == "new"
          puts "Enter name: "
          name = gets.chomp
          HTTParty.get("#{@url}/start?name=#{name}")
        else
          HTTParty.get("#{@url}/run?name=#{name}&command=#{command}")
        end
        puts response
      end
    end
  end
end