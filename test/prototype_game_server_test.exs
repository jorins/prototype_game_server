defmodule PrototypeGameServerTest do
  use ExUnit.Case
  doctest PrototypeGameServer

  test "greets the world" do
    assert PrototypeGameServer.hello() == :world
  end
end
