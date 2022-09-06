defmodule Fireblocks.Client do
  @moduledoc """
    Creates a HTTP connection to the [Fireblocks api](https://docs.fireblocks.io/),
    and queries it.
  """
  alias Fireblocks.ParseError

  @behaviour Fireblocks.Client.Behaviour

  def build_client do
    middleware = [
      {Tesla.Middleware.BaseUrl, base_url()},
      {Tesla.Middleware.Opts, [provider: "Fireblocks"]},
      {Tesla.Middleware.Timeout, timeout: 30_000},
      Fireblocks.Middleware.Sign,
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Logger, filter_headers: ~w[authorization]},
      Tesla.Middleware.Telemetry
    ]

    Tesla.client(middleware, {Tesla.Adapter.Finch, name: Fireblocks.Finch})
  end

  def supported_assets do
    build_client()
    |> Tesla.get("/v1/supported_assets")
    |> parse_response()
  end

  def parse_response(request) do
    case request do
      {:ok, %{status: 200, body: data}} -> {:ok, data}
      {:ok, %{status: 429}} -> {:error, :rate_limited}
      error -> ParseError.call(error)
    end
  end

  defp base_url, do: Application.get_env(:fireblocks, :base_url)
end
