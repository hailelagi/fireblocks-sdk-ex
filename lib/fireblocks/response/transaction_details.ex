defmodule Fireblocks.Response.TransactionDetails do
  @moduledoc false
  defstruct ~w[
    id
    asset_id
    requested_amount
    net_amount
    network_fee
    created_at
    tx_hash
    destination_address
    customer_ref_id
    confirmations
    tx_id
    status
  ]a

  @type t :: %__MODULE__{
          id: String.t(),
          asset_id: String.t(),
          requested_amount: pos_integer(),
          net_amount: pos_integer(),
          network_fee: pos_integer(),
          created_at: pos_integer(),
          tx_hash: String.t(),
          destination_address: String.t(),
          customer_ref_id: String.t(),
          confirmations: pos_integer(),
          tx_id: String.t(),
          status: String.t()
        }

  @spec new(map()) :: t()
  def new(fireblocks_result) do
    attrs = %{
      id: fireblocks_result["id"],
      asset_id: fireblocks_result["assetId"],
      requested_amount: fireblocks_result["requestedAmount"],
      net_amount: fireblocks_result["netAmount"],
      network_fee: fireblocks_result["networkFee"],
      created_at: fireblocks_result["createdAt"],
      tx_hash: fireblocks_result["txHash"],
      destination_address: fireblocks_result["destinationAddress"],
      customer_ref_id: fireblocks_result["customerRefId"],
      confirmations: fireblocks_result["numOfConfirmations"],
      tx_id: fireblocks_result["externalTxId"],
      status: fireblocks_result["status"]
    }

    struct!(__MODULE__, attrs)
  end
end
