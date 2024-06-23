defmodule PrototypeGameServer.MixProject do
  use Mix.Project

  def project do
    [
      app: :prototype_game_server,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: { PrototypeGameServer.Application, nil },
      extra_applications: [:logger],
    ]
  end

  defp deps do
    [
      {:ecto, "~> 3.11"},
      {:csv, "~> 3.2"},
      {:ex_doc, "~> 0.34", only: :dev, runtime: false},
    ]
  end
end
