require 'faye/websocket'
require 'eventmachine'
require 'json'
module Fik
  module Server
    class WebSocketClient
      def run
        EM.run {
          ws = Faye::WebSocket::Client.new('ws://0.0.0.0:9292/faye')

          ws.on :open do |event|
            p [:open]
            ws.send({message: 'Hello, world!'}.to_json)
          end

          ws.on :message do |event|
            p [:message, event.data]
          end

          ws.on :close do |event|
            p [:close, event.code, event.reason]
            ws = nil
          end
        }
      end
    end
  end
end
