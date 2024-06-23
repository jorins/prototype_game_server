defmodule PrototypeGameServer.Application do
  use Application

  def start(_type, _args) do
    universal_children = [
      { PrototypeGameServer.PlayerDb, nil }
    ]

    environment_children = case Application.fetch_env(:prototype_game_server, :children) do
      {:ok, list} -> list
      :error -> []
    end

    all_children = List.flatten([
      universal_children,
      environment_children,
    ])

    opts = [strategy: :one_for_one]

    Supervisor.start_link(all_children, opts)
  end
end
