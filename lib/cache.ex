defmodule Fireblocks.Cache do
  @moduledoc """
  This module handles some important preloading tasks into memory.
  e.g supported asset types fetched from fireblocks API, vault accounts etc.
  """
  use GenServer
  alias Fireblocks.Client

  @impl true
  def init(_state) do
    state = %{
      supported_assets: []
    }

    {:ok, state, {:continue, :load_supported_assets}}
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__, hibernate_after: 5000)
  end

  def get_supported_assets do
    GenServer.call(__MODULE__, :get_supported_assets)
  end

  @impl true
  def handle_continue(:load_supported_assets, %{supported_assets: _}) do
    state =
      case Client.supported_assets() do
        {:ok, supported_assets} -> %{supported_assets: supported_assets}
        _ -> %{supported_assets: []}
      end

    {:noreply, state}
  end

  @impl true
  def handle_call(:get_supported_assets, _, state) do
    supported_assets_list =
      case Map.get(state, :supported_assets) do
        [] ->
          {:ok, supported_assets} = Client.supported_assets()
          supported_assets

        list ->
          list
      end

    {:reply, supported_assets_list, Map.put(state, :supported_assets, supported_assets_list)}
  end
end
