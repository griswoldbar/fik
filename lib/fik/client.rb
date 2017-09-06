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
        response = HTTParty.get("#{@url}/run?command=#{command}")
        puts response
      end
    end
  end
end