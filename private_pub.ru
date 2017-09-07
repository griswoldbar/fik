# Run with: rackup private_pub.ru -s thin -E production
require "bundler/setup"
require "yaml"
require "faye"
require 'thin'
require "private_pub"

module PrivatePub
  #monkeypatch to remove the auth extension
  class << self
    def faye_app(options = {})
      options = {:mount => "/faye", :timeout => 45}.merge(options)
      Faye::RackAdapter.new(options)
    end
  end
end

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Faye::WebSocket.load_adapter('thin')

log_file = File.expand_path("../log/faye.log", __FILE__)
Faye.logger = Logger.new(log_file)

PrivatePub.load_config(File.expand_path("../config/private_pub.yml", __FILE__), 'production')
run PrivatePub.faye_app
