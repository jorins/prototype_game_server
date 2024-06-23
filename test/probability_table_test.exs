defmodule PrototypeGameServer.ProbabilityTableTest do
  alias PrototypeGameServer.ProbabilityTable
  alias PrototypeGameServer.Random.Manipulable

  use ExUnit.Case

  doctest PrototypeGameServer.ProbabilityTable

  defp testing_table do
    [
      red: 1,
      green: 2,
      blue: 3,
      blurple: 1,
    ]
  end

  defp expected_list do
    ~w"red green green blue blue blue blurple"a
  end
  
  test "selects as expected" do
    range = 1..length(expected_list())
    Enum.each(range, fn i -> 
      Manipulable.set_integer(i)
      expected = Enum.at(expected_list(), i - 1)
      assert ProbabilityTable.select(testing_table()) == expected
    end)
  end
end
