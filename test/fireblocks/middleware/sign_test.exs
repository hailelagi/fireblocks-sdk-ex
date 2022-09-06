defmodule Fireblocks.Middleware.SignTest do
  @moduledoc false
  use ExUnit.Case, async: true

  alias Fireblocks.Middleware.Sign

  describe "it creates a signed JWT access token" do
    test "token has the correct headers" do
      jwt = Sign.access_token("/test-live", nil)

      assert {:ok, %{"typ" => "JWT", "alg" => "RS256"}} = Joken.peek_header(jwt)
    end

    test "for a GET request" do
      test_uri = "/test-get"

      jwt = Sign.access_token(test_uri, nil)

      assert {:ok, claims} = Joken.peek_claims(jwt)
      assert claims["uri"] == test_uri
    end

    test "for a POST request" do
      test_uri = "/test-post"
      body = %{param: "test3"}
      body_hash = :crypto.hash(:sha256, Jason.encode!(body)) |> Base.encode16()

      jwt = Sign.access_token(test_uri, body)

      assert {:ok, claims} = Joken.peek_claims(jwt)
      assert claims["uri"] == test_uri
      assert claims["bodyHash"] == body_hash
    end
  end
end
