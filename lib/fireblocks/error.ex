defmodule Fireblocks.Error do
  @moduledoc false
  require Logger

  @type t :: %__MODULE__{
          error_code: integer(),
          http_code: non_neg_integer(),
          reason: binary()
        }

  defstruct ~w[reason http_code error_code]a

  @spec new(binary(), integer(), non_neg_integer()) :: t()
  def new(reason, error_code, http_code) do
    Logger.error("[Fireblocks] status: #{http_code}, error: #{reason}")

    struct!(__MODULE__,
      reason: reason,
      error_code: error_code,
      http_code: http_code
    )
  end
end
