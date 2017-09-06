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
      
      while true do
        printf "> "
        command = gets.chomp
        puts HTTParty.get("#{@url}/run?name=#{name}&command=#{command}")
      end
    end
  end
end