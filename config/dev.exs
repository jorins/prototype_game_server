import Config

config :prototype_game_server,
  random: PrototypeGameServer.Random.True,
  children: [
    { PrototypeGameServer.Random.Manipulable, nil }
  ]
