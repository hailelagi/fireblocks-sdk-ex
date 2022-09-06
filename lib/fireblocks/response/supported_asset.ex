defmodule Fireblocks.Response.SupportedAsset do
  @moduledoc false

  @type t :: %__MODULE__{
          asset_id: String.t(),
          asset_name: String.t(),
          asset_type: String.t(),
          native_asset: String.t(),
          decimal_points: pos_integer()
        }

  @fields ~w[asset_id asset_name asset_type native_asset decimal_points]a
  @enforce_keys @fields

  defstruct @fields

  @spec new(map()) :: t()
  def new(fireblocks_result) do
    attrs = %{
      asset_id: fireblocks_result["id"],
      asset_name: fireblocks_result["name"],
      asset_type: fireblocks_result["type"],
      native_asset: fireblocks_result["native_asset"],
      decimal_points: fireblocks_result["decimals"]
    }

    struct!(__MODULE__, attrs)
  end
end
