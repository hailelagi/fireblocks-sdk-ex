defmodule Fireblocks.Response.UnspentInputs do
  @moduledoc false
  defstruct ~w[tx_hash destination_address amount confirmations status]a

  @type t :: %__MODULE__{
          tx_hash: String.t(),
          amount: String.t(),
          destination_address: String.t(),
          confirmations: pos_integer(),
          status: String.t()
        }

  @spec new(map()) :: t()
  def new(fireblocks_result) do
    attrs = %{
      tx_hash: fireblocks_result["input"]["txHash"],
      amount: fireblocks_result["amount"],
      destination_address: fireblocks_result["address"],
      confirmations: fireblocks_result["confirmations"],
      status: fireblocks_result["status"]
    }

    struct!(__MODULE__, attrs)
  end
end
