defmodule Fireblocks.Input.GenerateVaultAccountDepositAddress do
  @moduledoc """
  Fireblocks input for creating vault account asset addresses. e.g BTC address, etc.
  """

  @derive Jason.Encoder
  defstruct ~w[vault_account_id asset_id description customer_ref_id]a

  @type t :: %__MODULE__{
          vault_account_id: binary(),
          asset_id: binary(),
          description: binary(),
          customer_ref_id: binary()
        }

  @spec new(binary(), binary(), binary(), binary()) :: t()
  def new(vault_account_id, asset_id, description, business_id) do
    attrs = %{
      vault_account_id: vault_account_id,
      asset_id: asset_id,
      description: description,
      customer_ref_id: business_id
    }

    struct!(__MODULE__, attrs)
  end
end
