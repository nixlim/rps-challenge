require './app/rpc.rb'
require './app/middlewares/multiplayer_backend.rb'

use RpsWeb::MultiplayerBackend

run RpsWeb::RPC
