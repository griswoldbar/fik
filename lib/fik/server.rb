require 'sinatra'
require 'sinatra/base'
require 'fik'
require 'fik/interfaces/web'
require 'pry-remote'
module Fik
  FOLDER = File.expand_path("../../../sample", __FILE__)
  
  class Server < Sinatra::Base  
    get '/run' do
      game.run(params[:command])
    end
    
    def game
      @@game ||= begin
        config = Fik::Configuration.new(FOLDER).build
        g = Fik::GameBuilder.new(config).build
        interface = Fik::Interfaces::Web.new(g)
      end
    end
  end
end