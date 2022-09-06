defmodule Fireblocks.Response.AddressStatus do
  @moduledoc false

  defstruct ~w[is_valid is_active requires_tag]a

  @type t :: %__MODULE__{
          is_valid: boolean(),
          is_active: boolean(),
          requires_tag: boolean()
        }

  @spec new(map()) :: t()
  def new(fireblocks_result) do
    attrs = %{
      is_valid: fireblocks_result["isValid"],
      is_active: fireblocks_result["isActive"],
      requires_tag: fireblocks_result["requiresTag"]
    }

    struct!(__MODULE__, attrs)
  end
end
