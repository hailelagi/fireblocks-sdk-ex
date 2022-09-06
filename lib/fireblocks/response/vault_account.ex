defmodule Fireblocks.Response.VaultAccount do
  @moduledoc false
  defstruct ~w[vault_account_id vault_account_name customer_ref_id assets]a

  @type t :: %__MODULE__{
          vault_account_id: String.t(),
          vault_account_name: String.t(),
          customer_ref_id: String.t(),
          assets: list()
        }

  @spec new(map()) :: t()
  def new(fireblocks_result) do
    attrs = %{
      vault_account_id: fireblocks_result["id"],
      vault_account_name: fireblocks_result["name"],
      customer_ref_id: fireblocks_result["customerRefId"],
      assets: fireblocks_result["assets"]
    }

    struct!(__MODULE__, attrs)
  end
end
