defmodule Fireblocks.Response.VaultAccountDepositAddress do
  @moduledoc false
  defstruct ~w[asset_id address legacy_address description tag bip_44_address_index]a

  @type t :: %__MODULE__{
          asset_id: String.t(),
          address: String.t(),
          legacy_address: String.t(),
          description: String.t(),
          tag: String.t(),
          bip_44_address_index: String.t()
        }

  @spec new(map()) :: t()
  def new(fireblocks_result, asset_id, description) do
    attrs = %{
      asset_id: asset_id,
      address: fireblocks_result["address"],
      legacy_address: fireblocks_result["legacyAddress"],
      description: description,
      tag: fireblocks_result["tag"],
      bip_44_address_index: fireblocks_result["bip44AddressIndex"] || 0
    }

    struct!(__MODULE__, attrs)
  end

  def new(fireblocks_result) do
    attrs = %{
      asset_id: fireblocks_result["assetId"],
      address: fireblocks_result["address"],
      legacy_address: fireblocks_result["legacyAddress"],
      description: fireblocks_result["description"],
      tag: fireblocks_result["tag"],
      bip_44_address_index: fireblocks_result["bip44AddressIndex"] || 0
    }

    struct!(__MODULE__, attrs)
  end
end
