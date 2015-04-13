# Run with: rackup private_pub.ru -s thin -E production
require "bundler/setup"
require "yaml"
require "redis"
require "faye"
require "private_pub"
require 'faye/redis'
load 'faye/client_event.rb'
load 'config/initializers/redis.rb'

Faye::WebSocket.load_adapter('thin')

PrivatePub.load_config(File.expand_path("../config/private_pub.yml", __FILE__), ENV["RAILS_ENV"] || "development")

options = {:mount => "/faye",
           :timeout => 25,
           :engine => {:type => Faye::Redis, :uri => ENV["REDISTOGO_URL"]}
         }

app = PrivatePub.faye_app(options)

  app.bind(:subscribe) do |client_id, channel|
    puts "Client SUBSCRIBE: #{client_id}:#{channel}"

    if channel[/\/users\/status\//]
      channel_key = channel.gsub(/\/users\/status\//,"")
      ClientEvent.user_subscribe(channel_key)
    end
  end

  app.bind(:unsubscribe) do |client_id, channel|
    puts "Client UNSUBSCRIBE: #{client_id}:#{channel}"

    if channel[/\/users\/status\//]
      channel_key = channel.gsub(/\/users\/status\//,"")
      ClientEvent.user_unsubscribe(channel_key)
    end
  end

  app.bind(:handshake) do |client_id|
    puts "Client HANDSHAKE: #{client_id}"
  end

  app.bind(:disconnect) do |client_id, channel|
    puts "Client DISCONNECT: #{client_id}"
  end

run app
