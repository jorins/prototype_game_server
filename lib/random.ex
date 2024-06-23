defmodule PrototypeGameServer.Random do
  @moduledoc """
  Get random numbers 
  """

  @backend Application.compile_env!(:prototype_game_server, :random)

  @doc "Get a random float between 0 and n"
  @spec float(float()) :: float()
  defdelegate float(n \\ 1.0), to: @backend

  @doc "Get a random integer between 1 and n"
  @spec integer(integer()) :: integer()
  defdelegate integer(n), to: @backend
end

defmodule PrototypeGameServer.Random.True do
  @moduledoc """
  True random functions, backed by Erlang's :rand
  """

  def float(n), do: :rand.uniform() * n
  def integer(n), do: :rand.uniform(n)
end

defmodule PrototypeGameServer.Random.Manipulable do
  @moduledoc """
  Manipulable random functions for testing. Note that since we set exactly what
  numbers to get via the `set_`-functions, the input for the getter functions
  is completely disregarded and a sequence of e.g. `set_float(2.0)` and
  `float(1.0)` will return `2.0`, which is not the behaviour described by the
  `Random` module.
  """

  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> %{integer: 0, float: 0.0} end, name: __MODULE__)
  end

  @doc "Set the number to be returned by `float()`"
  def set_float(n) when is_float(n) do
    Agent.update(__MODULE__, &%{&1 | float: n})
  end

  @doc "Set the number to be returned by `integer`"
  def set_integer(n) when is_integer(n) do
    Agent.update(__MODULE__, &%{&1 | integer: n})
  end

  def float(_n \\ 1.0), do: Agent.get(__MODULE__, & &1.float)
  def integer(_n), do: Agent.get(__MODULE__, & &1.integer)
end
