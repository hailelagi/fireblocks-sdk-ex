defmodule Fireblocks.Input.EstimateTxFee do
  @moduledoc false

  @derive Jason.Encoder
  defstruct ~w[
    vault_account_id
    asset_id
    address
    amount
    ]a

  @type t :: %__MODULE__{
          vault_account_id: binary(),
          asset_id: binary(),
          address: binary(),
          amount: binary()
        }

  @spec new(binary(), binary(), binary(), binary()) :: t()
  def new(vault_account_id, asset_id, destination_address, amount) do
    attrs = %{
      vault_account_id: vault_account_id,
      asset_id: asset_id,
      address: destination_address,
      amount: amount
    }

    struct!(__MODULE__, attrs)
  end
end
