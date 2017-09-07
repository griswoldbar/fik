require 'httparty'
require "faye"
require "fik/client/terminal"

module Fik
  module Client
    class WebClient
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
        messaging_service(name)

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
      
      def messaging_service(name)
        Thread.new do
          EM.run do 
            Faye::Client.new('http://0.0.0.0:9292/faye').subscribe("/#{name}") do |response|
              @terminal.messages(response["data"]["message"])
            end
          end
        end
      end      
    end
  end
end