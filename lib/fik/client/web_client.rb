require 'httparty'
require 'pry-remote'

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
        poll_messages(name)

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
      
      def poll_messages(name)
        Thread.new do
          while true do
            sleep 2
            response = HTTParty.get("#{@url}/messages?name=#{name}").body
            if response.present?
              @terminal.messages(response)
            end
          end
        end
      end
      
    end
  end
end