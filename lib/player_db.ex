alias PrototypeGameServer.Constants
alias PrototypeGameServer.Player

defmodule PrototypeGameServer.PlayerDb do
  use Agent

  # Map all known player names to full Player structs
  defp players_from_file do
    Constants.player_db_path()
    |> File.stream!([:trim_bom])
    |> CSV.decode!()
    |> Map.new(fn [id, name, region_str, mmr_str] ->
      region = String.to_existing_atom(region_str)
      {mmr, _} = Integer.parse(mmr_str)

      {
        id,
        %Player{
          name: name,
          region: region,
          mmr: mmr,
        }
      }
    end)
  end

  @doc """
  Initialise the PlayerDb
  """
  def start_link(_opts) do
    Agent.start_link(&players_from_file/0, name: __MODULE__)
  end

  def get_all() do
    Agent.get(__MODULE__, fn players -> players end)
  end

  def get_player(id) do
    Agent.get(__MODULE__, fn players -> Map.get(players, id) end)
  end

  def update_player(id, fun) do
    case Map.has_key?(get_all(), id) do
      false -> {:error, :unknown_player_id}
      true -> Agent.update(__MODULE__, fn players ->
        Map.update(players, id, nil, fun)
      end)
    end
  end

  def update_mmr(id, fun) do
    update_player(id, fn player -> 
      %Player{player | mmr: fun.(player.mmr) }
    end)
  end
end
