defmodule Fireblocks.TestUtils do
  @moduledoc false

  def supported_assets do
    ~S"""
    [
      {
        "id": "string",
        "name": "string",
        "type": "BASE_ASSET",
        "contractAddress": "string",
        "nativeAsset": "string",
        "decimals": "string"
      },
      {
        "id": "a0s0asfaslfks",
        "name": "ETHEREUM",
        "type": "BASE_ASSET",
        "contractAddress": "0xfakeaddress",
        "nativeAsset": "eth",
        "decimals": "0.115125151"
      }
    ]
    """
    |> Jason.decode!()
  end
end
