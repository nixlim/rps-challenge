require 'faye/websocket'
require 'json'
require 'erb'

module RpsWeb
  class MultiplayerBackend
    KEEPALIVE_TIME = 15


    def initialize(app)
      @app = app
      @clients = []
    end

    def call(env)
      if Faye::WebSocket.websocket?(env)
        ws = Faye::WebSocket.new(env, nil, {ping: KEEPALIVE_TIME})

        ws.on :open do |event|
          p [:open, ws.__id__]
          @clients << ws
          @connection = ws.__id__
          @clients.each { |ws| ws.send(@connection) }

        end

        ws.on :message do |event|
          p [:message, event.data]
          @clients.each { |ws| ws.send(event.data) }
        end

        ws.on :close do |event|
          p [:close, ws.__id__, event.code, event.reason]
          @clients.delete(ws)
          ws = nil
        end
        ws.rack_response
      else
        @app.call(env)
      end
    end
  end
end