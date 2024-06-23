import Config

config :prototype_game_server,
  random: PrototypeGameServer.Random.Manipulable,
  children: [
    { PrototypeGameServer.Random.Manipulable, nil }
  ]
