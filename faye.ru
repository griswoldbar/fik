lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'faye'

faye_server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 45)
run faye_server