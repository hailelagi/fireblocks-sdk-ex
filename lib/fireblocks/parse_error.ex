defmodule Fireblocks.ParseError do
  @moduledoc """
    HTTP error handler
  """
  alias Fireblocks.Error

  require Logger

  def call({:ok, %{status: 400, body: body}}) do
    Logger.error("[Fireblocks] Invalid params passed: #{inspect(body)}")
    body = Jason.decode!(body)

    {:error, Error.new(body["message"], body["code"], 400)}
  end

  def call({:ok, %{status: 401, body: body}}) do
    Logger.error("[Fireblocks] Unauthorized request")
    body = Jason.decode!(body)

    {:error, Error.new(body["message"], body["code"], 401)}
  end

  def call({:ok, %{status: 403, body: body}}) do
    Logger.error("[Fireblocks] Forbiden resource #{inspect(body)}")
    body = Jason.decode!(body)

    {:error, Error.new(body["message"], body["code"], 403)}
  end

  def call({:ok, %{status: 404, body: body}}) do
    Logger.error("[Fireblocks] Not found: #{inspect(body)}")
    body = Jason.decode!(body)

    {:error, Error.new(body["message"], body["code"], 404)}
  end

  def call({:ok, %{status: 500, body: body}}) do
    Logger.error("[Fireblocks] Internal server error.")
    body = Jason.decode!(body)

    {:error, Error.new(body["message"], body["code"], 500)}
  end

  def call(error) do
    Logger.error("[Fireblocks] unexpected error: #{inspect(error)}")
    {:error, Error.new("unexpected error", "unknown", 0)}
  end
end
