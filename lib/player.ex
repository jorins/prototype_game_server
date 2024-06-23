defmodule PrototypeGameServer.Player do
  @enforce_keys [:name, :region]
  defstruct [:name, :region, mmr: 1000]
end
