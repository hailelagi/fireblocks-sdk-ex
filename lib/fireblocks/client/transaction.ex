defmodule Fireblocks.Client.Transaction do
  @moduledoc """
    Transfer management endpoints
  """
  alias Fireblocks.Client
  @behaviour Fireblocks.Client.Behaviour.Transaction

  @doc """
     This API call is subject to rate limits.
  """
  def create(body) do
    Client.build_client()
    |> Tesla.post("/v1/transactions", body)
    |> Client.parse_response()
  end

  def retrieve_by_fireblocks_id(fireblocks_tx_id) do
    Client.build_client()
    |> Tesla.get("/v1/transactions/#{fireblocks_tx_id}")
    |> Client.parse_response()
  end

  def retrieve_by_tx_id(tx_id) do
    Client.build_client()
    |> Tesla.get("/v1/transactions/external_tx_id/#{tx_id}")
    |> Client.parse_response()
  end

  def cancel(fireblocks_tx_id) do
    Client.build_client()
    |> Tesla.post("/v1/transactions/#{fireblocks_tx_id}/cancel", nil)
    |> Client.parse_response()
  end

  def drop(fireblocks_tx_id, body) do
    Client.build_client()
    |> Tesla.post("/v1/transactions/#{fireblocks_tx_id}/drop", body)
    |> Client.parse_response()
  end

  def freeze(fireblocks_tx_id) do
    Client.build_client()
    |> Tesla.post("/v1/transactions/#{fireblocks_tx_id}/freeze", nil)
    |> Client.parse_response()
  end

  def unfreeze(fireblocks_tx_id) do
    Client.build_client()
    |> Tesla.post("/v1/transactions/#{fireblocks_tx_id}/unfreeze", nil)
    |> Client.parse_response()
  end

  def estimated_tx_fee(body) do
    Client.build_client()
    |> Tesla.post("/v1/transactions/estimate_fee", body)
    |> Client.parse_response()
  end

  def validate_destination_address(asset_id, address) do
    Client.build_client()
    |> Tesla.get("/v1/transactions/validate_address/#{asset_id}/#{address}")
    |> Client.parse_response()
  end

  def set_confirmation_threshold(fireblocks_tx_id, body) do
    Client.build_client()
    |> Tesla.post("/v1/transactions/#{fireblocks_tx_id}/set_confirmation_threshold", body)
    |> Client.parse_response()
  end
end
