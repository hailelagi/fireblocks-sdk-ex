defmodule Fireblocks.Response.EstimatedTxFee do
  @moduledoc false
  defstruct ~w[
    fee_per_byte
    gas_price
    gas_limit
    network_fee
    priority_fee
    base_fee
  ]a

  @type t :: %__MODULE__{
          fee_per_byte: binary(),
          gas_price: binary(),
          gas_limit: binary(),
          network_fee: binary(),
          priority_fee: binary(),
          base_fee: binary()
        }

  @spec new(map()) :: t()
  def new(fireblocks_result) do
    attrs = %{
      fee_per_byte: fireblocks_result["medium"]["feePerByte"],
      gas_price: fireblocks_result["medium"]["gasPrice"],
      gas_limit: fireblocks_result["medium"]["gasLimit"],
      network_fee: fireblocks_result["medium"]["networkFee"],
      priority_fee: fireblocks_result["medium"]["priorityFee"],
      base_fee: fireblocks_result["medium"]["baseFee"]
    }

    struct!(__MODULE__, attrs)
  end
end
