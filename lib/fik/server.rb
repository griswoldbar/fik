require 'sinatra'
require 'sinatra/base'
require 'fik'
require 'fik/interfaces/web'
require 'pry-remote'
module Fik
  FOLDER = File.expand_path("../../../sample", __FILE__)
  
  class Server < Sinatra::Base
    
    get '/start' do
      actor = Fik::Models::Actor.new("name" => params[:name], "starting_room" => "kitchen")
      add_game(actor)
      "Let the game begin..."
    end
    
    get '/run' do
      game = Fik::Interfaces::Web.new(games[params[:name]])
      game.run(params[:command])
    end
    
    get '/messages' do
      game = games[params[:name]]
      game.protagonist.read_messages.join("\n")
    end
    
    private
    
    def world
      @@world ||= Fik::World.new(rooms: config["rooms"], items: config["items"])
    end
    
    def config
      @@config ||= Fik::Configuration.new(FOLDER).build
    end
    
    def add_game(actor)
      @@games ||= {}
      @@games[actor.name] = Fik::Game.new(world, actor)
    end
    
    def games
      @@games
    end
  end
end