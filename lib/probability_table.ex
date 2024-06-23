defmodule PrototypeGameServer.ProbabilityTable do
  alias PrototypeGameServer.Random

  @typedoc """
  A probability table is a Keyword list of integers where the integer value
  represents the relative probability of a choice.

  ## Examples
  This table represents a 80% chance of giving :noop, 20% chance of giving :exit
      
      [noop: 4, exit: 1]

  This table represents a 1/3 chance of giving any of the choices

      [red: 1, green: 1, blue: 1]
  """
  @type probability_table() :: keyword(integer())


  @doc """
  Select a random entry from a probability table
  """
  @spec select(probability_table()) :: atom()
  def select(table) do
    target = table
      |> Keyword.values()
      |> Enum.sum()
      |> Random.integer()

    _select(table, target)
  end

  @spec _select([], any()) :: no_return()
  @spec _select(keyword(integer()), integer()) :: atom()

  defp _select([], _) do
    throw("Empty probability table")
  end

  defp _select([{key, probability} | _tail], target) when target <= probability do
    key
  end
  
  defp _select([{_key, probability} | tail], target) do
    _select(tail, target - probability)
  end
end
