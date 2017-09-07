lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rack'
require 'fik/server/web_socket_server'

run Fik::Server::WebSocketServer


# require 'eventmachine'
# require 'thin'
# Faye::WebSocket.load_adapter('thin')
# 
# thin = Rack::Handler.get('thin')
# 
# thin.run(Fik::Server::WebSocketServer, :Port => 9293)