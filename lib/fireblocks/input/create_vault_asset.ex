defmodule Fireblocks.Input.CreateVaultAsset do
  @moduledoc """
  Fireblocks input for creating vault account asset. Asset is synonymous to wallet e.g BTC, etc.
  """

  @derive Jason.Encoder
  defstruct ~w[vault_account_id asset_id]a

  @type t :: %__MODULE__{
          vault_account_id: binary(),
          asset_id: binary()
        }

  @spec new(binary(), binary()) :: t()
  def new(vault_account_id, asset_id) do
    attrs = %{
      vault_account_id: vault_account_id,
      asset_id: asset_id
    }

    struct!(__MODULE__, attrs)
  end
end
