defmodule Fireblocks.Middleware.Sign do
  @moduledoc """
    Middleware to sign each request
  """
  @behaviour Tesla.Middleware
  @impl Tesla.Middleware

  def call(env, next, _options) do
    "https://api.fireblocks.io" <> uri = env.url

    Tesla.put_headers(env, [
      {"X-API-KEY", api_key()},
      {"Idempotency-Key", idempotency_key()},
      {"authorization", "Bearer #{access_token(uri, env.body)}"}
    ])
    |> Tesla.run(next)
  end

  def access_token(uri, body) do
    json_body = if body == nil, do: "", else: Jason.encode!(body)
    timestamp = Joken.current_time()

    claims = %{
      uri: uri,
      nonce: generate_nonce(32),
      iat: timestamp,
      exp: timestamp + 29,
      sub: api_key(),
      bodyHash: :crypto.hash(:sha256, json_body) |> Base.encode16()
    }

    signer = Joken.Signer.create("RS256", %{"pem" => api_secret()})

    {:ok, token, _claims} = Joken.encode_and_sign(claims, signer)

    token
  end

  defp generate_nonce(length) do
    length
    |> :crypto.strong_rand_bytes()
    |> Base.encode32()
    |> binary_part(0, length)
  end

  defp api_key, do: Application.get_env(:fireblocks, :api_key)
  defp api_secret, do: Application.get_env(:fireblocks, :api_secret)
  defp idempotency_key, do: UUID.uuid4()
end
