defmodule Fireblocks.Client.Vault do
  @moduledoc """
    Vault management and interaction endpoints.
  """
  alias Fireblocks.Client
  @behaviour Fireblocks.Client.Behaviour.Vault

  def create_account(body) do
    Client.build_client()
    |> Tesla.post("/v1/vault/accounts", body)
    |> Client.parse_response()
  end

  def retrieve_account(id) do
    Client.build_client()
    |> Tesla.get("/v1/vault/accounts/#{id}")
    |> Client.parse_response()
  end

  def create_asset_wallet_for_account(input) do
    Client.build_client()
    |> Tesla.post("/v1/vault/accounts/#{input.vault_account_id}/#{input.asset_id}", nil)
    |> Client.parse_response()
  end

  def fetch_account_wallet_balance(vault_account_id, asset_id) do
    Client.build_client()
    |> Tesla.get("/v1/vault/accounts/#{vault_account_id}/#{asset_id}")
    |> Client.parse_response()
  end

  def refresh_account_wallet_balance(vault_account_id, asset_id) do
    Client.build_client()
    |> Tesla.post("/v1/vault/accounts/#{vault_account_id}/#{asset_id}/balance", nil)
    |> Client.parse_response()
  end

  def generate_deposit_address_for_asset(body) do
    Client.build_client()
    |> Tesla.post(
      "/v1/vault/accounts/#{body.vault_account_id}/#{body.asset_id}/addresses",
      body
    )
    |> Client.parse_response()
  end

  def retrieve_account_wallet_deposit_addresses(vault_account_id, asset_id) do
    Client.build_client()
    |> Tesla.get("/v1/vault/accounts/#{vault_account_id}/#{asset_id}/addresses")
    |> Client.parse_response()
  end

  def retrieve_unspent_inputs(vault_account_id, asset_id) do
    Client.build_client()
    |> Tesla.get("/v1/vault/accounts/#{vault_account_id}/#{asset_id}/unspent_inputs")
    |> Client.parse_response()
  end
end
