require 'faye/websocket'
require 'sinatra'
require 'sinatra/base'
require 'pry'

module Fik
  module Server
    class WebSocketServer < Sinatra::Base
      get "/" do
        ws = Faye::WebSocket.new(env)

        ws.on :message do |event|
          ws.send(event.data)
        end
    
        ws.on :close do |event|
          p [:close, event.code, event.reason]
          ws = nil
        end
    
        # Return async Rack response
        ws.rack_response
      end
    end
  end
end

# WebSocketServer = lambda do |env|
# 
#   if Faye::WebSocket.websocket?(env)
#     puts "ws"
# 
#     ws = Faye::WebSocket.new(env)
# 
#     ws.on :message do |event|
#       ws.send(event.data)
#     end
# 
#     ws.on :close do |event|
#       p [:close, event.code, event.reason]
#       ws = nil
#     end
# 
#     # Return async Rack response
#     ws.rack_response
# 
#   else
#     # Normal HTTP request
#     binding.pry
#     puts "web"
#     [200, {'Content-Type' => 'text/plain'}, ['Hello']]
#   end
# end