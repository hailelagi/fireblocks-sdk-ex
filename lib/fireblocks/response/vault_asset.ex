defmodule Fireblocks.Response.VaultAsset do
  @moduledoc false

  defstruct ~w[
    asset_id
    total_balance
    available_balance
    pending_amount
    locked_amount
    frozen_amount
    max_bip_44_address_index_used
    max_bip_44_change_address_index_used
    block_height
    block_hash
    ]a

  @type t :: %__MODULE__{
          asset_id: String.t(),
          total_balance: String.t(),
          available_balance: String.t(),
          pending_amount: String.t(),
          locked_amount: String.t(),
          frozen_amount: String.t(),
          max_bip_44_address_index_used: pos_integer(),
          max_bip_44_change_address_index_used: pos_integer(),
          block_height: String.t(),
          block_hash: String.t()
        }

  @spec new(map()) :: t()
  def new(fireblocks_result) do
    attrs = %{
      asset_id: fireblocks_result["id"],
      total_balance: fireblocks_result["total"],
      available_balance: fireblocks_result["available"],
      pending_amount: fireblocks_result["pending"],
      frozen_amount: fireblocks_result["frozen"],
      locked_amount: fireblocks_result["lockedAmount"],
      max_bip_44_address_index_used: fireblocks_result["maxBip44AddressIndexUsed"],
      max_bip_44_change_address_index_used: fireblocks_result["maxBip44ChangeAddressIndexUsed"],
      block_height: fireblocks_result["blockHeight"],
      block_hash: fireblocks_result["blockHash"]
    }

    struct!(__MODULE__, attrs)
  end
end
