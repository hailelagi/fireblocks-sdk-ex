defmodule Fireblocks.Response.SupportedAssetTest do
  @moduledoc false
  use ExUnit.Case, async: true

  alias Fireblocks.Response.SupportedAsset

  test "supported asset" do
    assert SupportedAsset.new(asset_response())
  end

  defp asset_response do
    ~S"""
    {
    "id": "string",
    "name": "string",
    "type": "BASE_ASSET",
    "contractAddress": "string",
    "nativeAsset": "string",
    "decimals": "string"
    }
    """
    |> Jason.decode!()
  end
end
