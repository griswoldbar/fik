lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'fik/server/web_server'
require "private_pub"


PrivatePub.load_config(File.expand_path("../config/private_pub.yml", __FILE__), 'production')

run Fik::Server::WebServer
