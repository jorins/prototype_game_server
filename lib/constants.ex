defmodule PrototypeGameServer.Constants do
  @doc """
  A list of recognised regions players can belong to and games take place in
  """
  def regions do
    [
      :gensokyo,
      :atlantis,
      :luna,
      :mars,
      :antarctica
    ]
  end

  @doc "A list of game modes"
  def game_modes do
    [
      :singles,
      :teams,
    ]
  end

  @doc "The different ladders"
  def ladders do
    [
      :competitive,
      :casual
    ]
  end

  @doc "Path of the faux player database used at startup"
  def player_db_path do
    "players.csv"
  end
end
