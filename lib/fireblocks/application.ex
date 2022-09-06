defmodule Fireblocks.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # TODO: cache
      # {Fireblocks.Cache, %{}},
      {Finch, name: Fireblocks.Finch}
    ]

    opts = [strategy: :one_for_one, name: Fireblocks.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
