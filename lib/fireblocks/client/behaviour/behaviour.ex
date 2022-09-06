defmodule Fireblocks.Client.Behaviour do
  @moduledoc false

  alias Fireblocks.Error
  alias Fireblocks.Response.SupportedAsset

  @callback supported_assets() :: {:ok, list(SupportedAsset.t())} | {:error, Error.t()}
end
