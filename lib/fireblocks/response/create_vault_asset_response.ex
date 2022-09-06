defmodule Fireblocks.Response.CreateVaultAssetResponse do
  @moduledoc false

  defstruct ~w[vault_account_id address legacy_address tag eos_account_name]a

  @type t :: %__MODULE__{
          vault_account_id: String.t(),
          address: String.t(),
          legacy_address: String.t(),
          tag: String.t(),
          eos_account_name: String.t()
        }

  @spec new(map()) :: t()
  def new(fireblocks_result) do
    attrs = %{
      vault_account_id: fireblocks_result["id"],
      address: fireblocks_result["address"],
      legacy_address: fireblocks_result["legacyAddress"],
      tag: fireblocks_result["tag"],
      eos_account_name: fireblocks_result["eosAccountName"]
    }

    struct!(__MODULE__, attrs)
  end
end
